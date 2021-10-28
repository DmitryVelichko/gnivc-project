import {
  Button,
  DatePicker,
  FileUploader,
  ResultFilesObjectType,
  Select,
  TextAreaField,
  TextField,
  Typography,
  Option,
  Icon,
} from '@ff/ui-kit';
import React from 'react';
import { useHistory, useParams } from 'react-router-dom';
import { observer } from 'mobx-react-lite';

import styles from './TaskForm.module.scss';
import SkillStore from '../../../stores/skillStore/skillStore';
import { Skill } from '../../../types/Skill';
import TaskService from '../../../services/taskService/taskService';
import {
  CreateTaskInputType,
  UpdateTaskInputType,
} from '../../../services/taskService/inputTypes';
import AppStore from '../../../stores/appStore/AppStore';
import { TaskFile } from '../../../types/Task';

const errorMessages = {
  empty: 'Поле не может быть пустым!',
  many: 'Слишком много символов!',
  few: 'Слишком мало символов!',
  incorrect: 'Неверное значение!',
};

const skillLablesToValues = (skillStore: Option[], skills: Skill[]) => {
  const array: string[] = [];
  skillStore.forEach((item) => {
    skills.forEach((skill) => {
      if (item.label === skill.name) {
        array.push(item.value);
      }
    });
  });
  return array;
};

type RouteParams = {
  id: string;
};

const TaskForm: React.FC = observer(() => {
  // todo: перенести состояние в стор
  // todo: разделить на addtask и edittask
  const { id } = useParams<RouteParams>();

  const history = useHistory();

  const [name, setName] = React.useState<string>('');
  const [nameError, setNameError] = React.useState('');
  const [nameDirty, setNameDirty] = React.useState(false);
  const changeNameHandler = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = e.currentTarget;
    setNameDirty(true);
    setName(value);
    if (!value.length) {
      setNameError(errorMessages.empty);
    } else if (value.length > 40) {
      setNameError(errorMessages.many);
    } else {
      setNameError('');
    }
  };

  const [price, setPrice] = React.useState<string>('');
  const [priceError, setPriceError] = React.useState('');
  const [priceDirty, setPriceDirty] = React.useState(false);
  const changePriceHandler = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = e.currentTarget;
    setPriceDirty(true);
    setPrice(value);
    if (Number(value) < 0 || Number(value) > 10000000) {
      setPriceError(errorMessages.incorrect);
    } else {
      setPriceError('');
    }
  };

  const [skills, setSkills] = React.useState<string[]>([]);
  const [skillsError] = React.useState('');
  const changeSkillsHandler = (values: string[] | string) => {
    if (Array.isArray(values)) {
      setSkills(values);
    }
  };

  const [duration, setDuration] = React.useState<string>('');
  const [durationError, setDurationError] = React.useState('');
  const [durationDirty, setDurationDirty] = React.useState(false);
  const changeDurationHandler = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = e.currentTarget;
    setDurationDirty(true);
    setDuration(value);
    if (Number(value) < 0 || Number(value) > 365) {
      setDurationError(errorMessages.incorrect);
    } else {
      setDurationError('');
    }
  };

  const [dueDate, setDueDate] = React.useState<string>('');
  const [dueDateError, setDueDateError] = React.useState('');
  const [dueDateDirty, setDueDateDirty] = React.useState(false);
  const changeDueDateHandler = (value: string) => {
    setDueDateDirty(true);
    setDueDate(value);
    if (value === '' && dueDateDirty) {
      setDueDateError(errorMessages.empty);
    } else {
      setDueDateError('');
    }
  };

  const [weight, setWeight] = React.useState<string>('');
  const [weightError, setWeightError] = React.useState('');
  const [weightDirty, setWeightDirty] = React.useState(false);
  const changeWeightHandler = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = e.currentTarget;
    setWeightDirty(true);
    setWeight(value);
    if (Number(value) < 0 || Number(value) > 100) {
      setWeightError(errorMessages.incorrect);
    } else {
      setWeightError('');
    }
  };

  const [link, setLink] = React.useState<string>('');
  const [linkError, setLinkError] = React.useState('');
  const changeLinkHandler = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = e.currentTarget;
    setLink(value);
    if (value.length > 100) {
      setLinkError(errorMessages.many);
    } else if (value.length > 0 && value.length < 2) {
      setLinkError(errorMessages.few);
    } else {
      setLinkError('');
    }
  };

  const [description, setDescription] = React.useState<string>('');
  const [descriptionError, setDescriptionError] = React.useState('');
  const [descriptionDirty, setDescriptionDirty] = React.useState(false);
  const changeDescriptionHandler = (
    e: React.ChangeEvent<HTMLTextAreaElement>,
  ) => {
    const { value } = e.currentTarget;
    setDescriptionDirty(true);
    setDescription(value);
    if (!value.length) {
      setDescriptionError(errorMessages.empty);
    } else if (value.length < 40) {
      setDescriptionError(errorMessages.few);
    } else if (value.length > 1200) {
      setDescriptionError(errorMessages.many);
    } else {
      setDescriptionError('');
    }
  };

  const [attachments, setAttachments] = React.useState<ResultFilesObjectType | null>(null);
  const [attachmentsError, setAttachmentsError] = React.useState('');
  const changeAttachmentsHandler = (files: ResultFilesObjectType) => {
    setAttachments(files);
  };

  const [oldAttachments, setOldAttachments] = React.useState<{
    data: TaskFile[];
    deleted: TaskFile[];
  } | null>(null);

  const deleteFileHandler = (fileId: number) => {
    const deletedFile = oldAttachments?.data.find((file) => file.id === fileId);
    if (oldAttachments?.data !== undefined && deletedFile !== undefined) {
      setOldAttachments({
        data: oldAttachments.data,
        deleted: [...oldAttachments?.deleted, deletedFile],
      });
    }
  };

  React.useEffect(() => {
    if (id !== undefined) {
      TaskService.getTask(Number(id)).then((task) => {
        setName(task.name);
        setPrice(task.price.toString());
        setSkills(skillLablesToValues(SkillStore.skills, task.skills || []));
        setDuration(task.duration.toString());
        setDueDate(task.dueDate);
        setWeight(task.weight.toString());
        setLink(task.link || '');
        setDescription(task.description);
        if (task.attachments) {
          setOldAttachments({
            data: task.attachments,
            deleted: [],
          });
        }
        setNameDirty(true);
        setPriceDirty(true);
        setWeightDirty(true);
        setDueDateDirty(true);
        setDurationDirty(true);
        setDescriptionDirty(true);
      });
    } else {
      setName('');
      setPrice('');
      setSkills([]);
      setDuration('');
      setDueDate('');
      setWeight('');
      setLink('');
      setDescription('');
      setOldAttachments(null);
      setAttachments(null);
      setNameDirty(false);
      setPriceDirty(false);
      setWeightDirty(false);
      setDueDateDirty(false);
      setDurationDirty(false);
      setDescriptionDirty(false);
    }
  }, [id]);

  const [formIsError, setFormIsError] = React.useState<boolean>(true);

  React.useEffect(() => {
    if (
      !nameDirty
      || !priceDirty
      || !weightDirty
      || !dueDateDirty
      || !durationDirty
      || !descriptionDirty
      || nameError
      || priceError
      || skillsError
      || durationError
      || dueDateError
      || weightError
      || linkError
      || descriptionError
      || attachmentsError
    ) {
      setFormIsError(true);
    } else {
      setFormIsError(false);
    }
  }, [
    nameDirty,
    priceDirty,
    weightDirty,
    dueDateDirty,
    durationDirty,
    descriptionDirty,
    nameError,
    priceError,
    skillsError,
    durationError,
    dueDateError,
    weightError,
    linkError,
    descriptionError,
    attachmentsError,
  ]);

  const createTask = async () => {
    const newTask: CreateTaskInputType = {
      name,
      price: Number(price),
      duration: Number(duration),
      dueDate,
      weight: Number(weight),
      description,
    };
    if (link?.length > 1) {
      newTask.link = link;
    }
    if (skills.length) {
      newTask.skills = skills.map((value) => Number(value));
    }
    if (attachments !== null) {
      const files: File[] = [];
      Object.entries(attachments).forEach(([filename, file]) => {
        const newFile = new File([file.content], filename, {
          type: file.mime,
          ...file,
        });
        files.push(newFile);
      });
      newTask.attachments = files;
    }

    await TaskService.createTask(newTask);
  };

  const updateTask = async () => {
    const newTask: UpdateTaskInputType = {
      name,
      price: Number(price),
      skills: skills.map((value) => Number(value)),
      duration: Number(duration),
      dueDate,
      weight: Number(weight),
      description,
      oldAttachments: oldAttachments?.deleted.map((file) => file.id),
    };
    if (link.length > 1) {
      newTask.link = link;
    }
    if (attachments !== null) {
      const files: File[] = [];
      Object.entries(attachments).forEach(([filename, file]) => {
        const newFile = new File([file.content], filename, {
          type: file.mime,
          ...file,
        });
        files.push(newFile);
      });
      newTask.newAttachments = files;
    }
    await TaskService.updateTask(newTask, Number(id));
  };

  const postTask = async (e: React.FormEvent<HTMLButtonElement>) => {
    e.preventDefault();
    if (!formIsError) {
      try {
        if (id !== undefined) {
          await updateTask();
        } else {
          await createTask();
        }
        history.push('/own-tasks/3');
      } catch {
        AppStore.setError();
      }
    }
  };
  return (
    <>
      <div className={styles.component}>
        <Typography.Title className={styles.title} level={3}>
          Ваша задача
        </Typography.Title>
        <form>
          <TextField
            className={styles.option}
            name="name"
            label="Название"
            value={name}
            onChange={changeNameHandler}
            error={Boolean(nameError)}
            errorMessage={nameError}
          />
          <TextField
            className={styles.option}
            name="price"
            label="Премия (руб.)"
            type="number"
            value={price.toString()}
            onChange={changePriceHandler}
            error={Boolean(priceError)}
            errorMessage={priceError}
          />
          <Select
            className={styles.option}
            label="Технологии"
            name="skills"
            multiple
            options={SkillStore.skills}
            showSearch
            value={skills}
            onChange={changeSkillsHandler}
            error={Boolean(skillsError)}
          />

          <TextField
            className={styles.option}
            name="duration"
            label="Оцененная длительность (в днях)"
            type="number"
            value={duration.toString()}
            onChange={changeDurationHandler}
            error={Boolean(durationError)}
            errorMessage={durationError}
          />

          <DatePicker
            className={styles.option}
            name="dueDate"
            label="Дедлайн"
            fullWidth
            value={dueDate}
            onChange={changeDueDateHandler}
            format="YYYY-MM-DD"
            error={Boolean(dueDateError)}
            errorMessage={dueDateError}
          />

          <TextField
            className={styles.option}
            name="weight"
            label="Требуемый процент задействования исполнителя (%)"
            type="number"
            value={weight.toString()}
            onChange={changeWeightHandler}
            error={Boolean(weightError)}
            errorMessage={weightError}
          />
          <TextField
            className={styles.option}
            name="link"
            label="Ссылка"
            value={link}
            onChange={changeLinkHandler}
            error={Boolean(linkError)}
            errorMessage={linkError}
          />
          <div className={styles.option}>
            <TextAreaField
              fullWidth
              name="description"
              label="Текстовое поле"
              placeholder="Текстовое поле"
              value={description}
              onChange={changeDescriptionHandler}
              error={Boolean(descriptionError)}
              errorMessage={descriptionError}
            />
          </div>
          {oldAttachments?.data.length ? (
            <div className={styles.option}>
              <div className={styles.optionTitle}>Старые файлы</div>
              {oldAttachments.data.map((file) => (
                <div
                  key={file.id}
                  className={styles.optionFile}
                  style={
                    oldAttachments.deleted.find(
                      // todo:  изменить oldattachments
                      (item) => item.id === file.id,
                    ) && { textDecoration: 'line-through' }
                  }
                >
                  {file.filename}

                  {!oldAttachments.deleted.find(
                    (item) => item.id === file.id,
                  ) && (
                    <button
                      type="button"
                      onClick={() => deleteFileHandler(file.id)}
                    >
                      <Icon name="close" fontSize={14} />
                    </button>
                  )}
                </div>
              ))}
            </div>
          ) : null}
          <div className={styles.optionTitle}>Новые файлы</div>
          <FileUploader
            className={styles.option}
            name="attachments"
            accept="image/*, .zip, application/pdf"
            multiple
            onChange={changeAttachmentsHandler}
            maxFileSizeInBytes={50000000}
            withPreview
          />
          <Button
            disabled={formIsError}
            className={styles.option}
            type="primary"
            htmlType="submit"
            onClick={postTask}
          >
            Сохранить
          </Button>
        </form>
      </div>
    </>
  );
});

export default TaskForm;
