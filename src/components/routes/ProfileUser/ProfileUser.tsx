import React, { useCallback, useMemo, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import {
  Select,
  Button,
  Tag,
  Icon,
} from '@ff/ui-kit';
import { observer } from 'mobx-react-lite';
import { useKeycloak } from '@react-keycloak/web';

import ErrorMessage from '../../ErrorMessage';
import ProfileUserStore from '../../../stores/profileUserStore/profileUserStore';
import SkillStore from '../../../stores/skillStore/skillStore';
import classes from './ProfileUser.module.scss';
import '@ff/ui-kit/lib/styles/fns.theme.css';

type RouteParams = {
  id: string;
};

const ProfileUser: React.FC = observer(() => {
  const {
    isLoading: isLoadingSkills, isError: isErrorSkills, skills, getAllSkills,
  } = SkillStore;

  const {
    isLoading: isLoadingUser, isError: isErrorUser, user, wantedSkills, learnedSkills,
    setWantedSkills, updateWantedSkills, getUserByID, getUserByGUID,
  } = ProfileUserStore;

  const { keycloak } = useKeycloak();

  const currentId = keycloak.tokenParsed?.sub;

  const { id: userId } = useParams<RouteParams>();

  const [changeInterface, setChangeInterface] = React.useState<boolean>(true);

  useMemo(() => {
    if (user && currentId !== undefined) {
      setChangeInterface(user.guid === currentId);
    }
  }, [
    user,
    currentId,
  ]);

  const isLoading = useMemo(() => isLoadingUser || isLoadingSkills, [
    isLoadingUser,
    isLoadingSkills,
  ]);

  useEffect(() => {
    const fetchAPI = async () => {
      await getAllSkills();

      if (userId === undefined && currentId !== undefined) {
        await getUserByGUID(currentId);
        return;
      }

      const id = parseInt(userId, 10);

      await getUserByID(id);
    };
    fetchAPI();
  }, [currentId, getAllSkills, getUserByGUID, getUserByID, userId]);

  const saveSkills = useCallback(() => {
    const wantedSkillsID = wantedSkills.map((skill) => skill.id);
    setWantedSkills(wantedSkillsID);
  }, [setWantedSkills, wantedSkills]);

  return (
    <div className={classes.container}>
      {(isErrorUser || isErrorSkills) && (
        <ErrorMessage>
          <span>Не удалось загрузить данные</span>
          <Icon name="emoji_frown" />
        </ErrorMessage>
      )}

      {(!isErrorUser && !isErrorSkills) && (
        <>
          <div className={classes.userName}>{user?.name}</div>
          <div className={classes.item}>
            <div className={classes.listName}>Хорошо знаю</div>
            <div className={classes.list}>
              {learnedSkills.map((skill) => (
                <Tag
                  label={skill.name}
                  key={skill.id}
                  type="success"
                  className={classes.listTag}
                />
              ))}
            </div>
          </div>

          <div className={classes.item}>
            <Select
              label="Хотел бы узнать"
              disabled={!changeInterface || isLoading}
              options={skills}
              value={wantedSkills.map((skill) => skill.id.toString())}
              className={`${classes.select} ${!changeInterface ? classes.selectDisabled : ''}`}
              placeholder="Выберите навык из списка"
              multiple
              onChange={updateWantedSkills}
            />
          </div>

          {changeInterface && (
            <div className={classes.item}>
              <Button
                onClick={saveSkills}
                variant="outline"
                type="primary"
                disabled={isLoading}
                className={classes.button}
              >
                Сохранить
              </Button>
            </div>
          )}
        </>
      )}
    </div>
  );
});

export default ProfileUser;
