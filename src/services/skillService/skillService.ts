import axios from 'axios';

class SkillService {
  skillsQueryFragment = `
  id
  name
  `;

  GET_ALL_SKILLS = `
  query getAllSkills {
    getAllSkills{
        ${this.skillsQueryFragment}
     }
  }
  `;

  getAllSkills = async () => {
    const skills = await axios.post('http://localhost:4000/api', {
      query: this.GET_ALL_SKILLS,
    });

    return skills.data.data.getAllSkills;
  };
}

export default new SkillService();
