import 'dart:collection';

import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/models/users/user.dart';

ProgramTemplate thePowerBuildingProgram = ProgramTemplate(
  id: '0', title: 'The PowerBuilding Program',
  author: UserIdentifier(displayName: 'kevboah', uid: '0'),
  description: '',
  pathToMedia: null,
  trainingBlocks: [
    TrainingBlock(
      split: Week(
        monday: Day(
          label: 'squat 1',
          exercises: SplayTreeMap.from({
            0: Squat(sets: 3, reps: 8, prescribedWorkload: WorkloadPrescriber(WorkloadPrescriberType.rpe, value: 0.8)),
            1: Exercise(name: 'Leg press', sets: 3, reps: 10),
            2: Exercise(name: 'Lunges', sets: 3, reps: 8, coachNotes: 'each leg'),
            3: Exercise(name: 'Hanging leg raises', sets: 3, reps: 10),
            4: DurationExercise()
          })
        ),
        tuesday: Day(

        ),
      ),
      weeks: {
        0: Week(
          monday: Day(
            exercises: SplayTreeMap.from({0: Squat(sets: 3, reps: 8, prescribedWorkload: WorkloadPrescriber(WorkloadPrescriberType.rpe, value: 0.8))}),
          )
        ),
        1: Week(),
        2: Week(),
        3: Week(),
        4: Week(), 
        5: Week(),
        6: Week(),
        7: Week(),
        8: Week(),
        9: Week(),
        10: Week(),
        11: Week(),
      }
    )
  ]
);