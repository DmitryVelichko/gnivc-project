import axios from 'axios';

class UserService {
  userQueryFragment = `
   id
   guid
   name
   email
   learnedSkills{
      id
      name
   }
   wantedSkills{
      id
      name
   }`;

  GET_USER_BY_GUID = `
   query getUserByGUID($userGuid: String!) {
    getUserByGUID(userGUID: $userGuid) {
         ${this.userQueryFragment}
      }
   }
   `;

  GET_USER_BY_ID = `
   query getUserByID($ID: Int!) {
    getUserByID(ID: $ID) {
         ${this.userQueryFragment}
      }
   }
   `;

  SET_WANTED_SKILLS = `
  mutation setWantedSkills($skills: [Int!]) {
    setWantedSkills(skills: $skills) 
   }
   `;

  linkQuery = 'http://localhost:4000/api';

  postQuery = async (query: string, variables: unknown = {}, headers = false) => {
    const authHeaders = {
      Authorization: localStorage.getItem('token') || '',
    };

    const data = await axios.post(
      this.linkQuery,
      {
        query,
        variables,
      },
      headers
        ? {
          headers: authHeaders,
        }
        : {},
    );

    return data.data.data;
  };

  getUserByGUID = async (userGuid: string) => {
    const user = await axios.post('http://localhost:4000/api', {
      query: this.GET_USER_BY_GUID,
      variables: {
        userGuid,
      },
    });

    return user.data.data.getUserByGUID;
  };

  getUserByID = async (ID: number) => {
    const user = await axios.post('http://localhost:4000/api', {
      query: this.GET_USER_BY_ID,
      variables: {
        ID,
      },
    });

    return user.data.data.getUserByID;
  };

  setWantedSkills = async (skills: number[]) => {
    const data = await this.postQuery(this.SET_WANTED_SKILLS, { skills }, true);
    return data.setWantedSkills;
  };
}

export default new UserService();
