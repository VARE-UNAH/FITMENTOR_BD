CREATE TABLE Person (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dni VARCHAR(13),
    firstName VARCHAR(45) NOT NULL,
    middleName VARCHAR(45),
    lastName VARCHAR(45) NOT NULL,
    secondLastName VARCHAR(45),
    phoneNumber VARCHAR(20)
);

CREATE TABLE User (
    id INT PRIMARY KEY AUTO_INCREMENT,
    active BOOLEAN DEFAULT TRUE,
    personId INT UNIQUE,
    email VARCHAR(100) UNIQUE NOT NULL,
    firebaseUid VARCHAR(128) UNIQUE,
    verified BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_person FOREIGN KEY (personId) REFERENCES Person(id) ON DELETE CASCADE
);

CREATE TABLE Image (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    url VARCHAR(255) NOT NULL,
    contentType VARCHAR(50) NOT NULL,
    size INT NOT NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    avatar BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_user_image FOREIGN KEY (userId) REFERENCES User(id) ON DELETE CASCADE
);

CREATE TABLE Plan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    name VARCHAR(100),
    description VARCHAR(225),
    price FLOAT NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES User(id) ON DELETE CASCADE
);

CREATE TABLE Client (
    id INT PRIMARY KEY AUTO_INCREMENT,
    active BOOLEAN DEFAULT TRUE,
    dni VARCHAR(13) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    firstName VARCHAR(45) NOT NULL,
    middleName VARCHAR(45),
    lastName VARCHAR(45) NOT NULL,
    secondLastName VARCHAR(45),
    phoneNumber VARCHAR(20),
    age INT NOT NULL,
    height FLOAT NOT NULL,
    planId INT NOT NULL,
    CONSTRAINT fk_plan FOREIGN KEY (planId) REFERENCES Plan(id) ON DELETE CASCADE
);

CREATE TABLE Progress (
    id INT PRIMARY KEY AUTO_INCREMENT,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    IMC FLOAT,
    fatperc INT,
    weight FLOAT NOT NULL,
    clientId INT NOT NULL,
    CONSTRAINT fk_client FOREIGN KEY (clientId) REFERENCES Client(id) ON DELETE CASCADE
);

CREATE TABLE Training_Plan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ClientId INT UNIQUE NOT NULL,
    IH INT NOT NULL,
    FH INT NOT NULL,
    CONSTRAINT fk_client_training_plan FOREIGN KEY (ClientId) REFERENCES Client(id) ON DELETE CASCADE
);

CREATE TABLE Day (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(10) NOT NULL
);

CREATE TABLE Training_Day (
    id INT PRIMARY KEY AUTO_INCREMENT,
    training_PlanId INT NOT NULL,
    dayId INT NOT NULL,
    name VARCHAR(50),
    CONSTRAINT fk_training_plan FOREIGN KEY (training_PlanId) REFERENCES Training_Plan(id),
    CONSTRAINT fk_day FOREIGN KEY (dayId) REFERENCES Day(id)
);

CREATE TABLE Training_Day_Exercise (
    trainingDayId INT NOT NULL,
    exerciseId INT NOT NULL,
    sets INT,
    reps INT,
    weight FLOAT,
    PRIMARY KEY (trainingDayId, exerciseId),
    CONSTRAINT fk_training_day FOREIGN KEY (trainingDayId) REFERENCES Training_Day(id) ON DELETE CASCADE,
    CONSTRAINT fk_exercise FOREIGN KEY (exerciseId) REFERENCES Exercise(id) ON DELETE CASCADE
);

CREATE TABLE Trained_Day (
    id INT PRIMARY KEY AUTO_INCREMENT,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    trained BOOLEAN NOT NULL,
    training_DayId INT NOT NULL,
    CONSTRAINT fk_training_day_trained FOREIGN KEY (training_DayId) REFERENCES Training_Day(id)
);

CREATE TABLE MuscularGroup (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL
);

CREATE TABLE Exercise (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL,
    MuscularGroupId INT NOT NULL,
    CONSTRAINT fk_muscular_group FOREIGN KEY (MuscularGroupId) REFERENCES MuscularGroup(id)
);

CREATE TABLE Food_Plan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ClientId INT UNIQUE NOT NULL,
    CONSTRAINT fk_client_food_plan FOREIGN KEY (ClientId) REFERENCES Client(id) ON DELETE CASCADE
);

CREATE TABLE Food_Day (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Food_PlanId INT NOT NULL,
    dayId INT NOT NULL,
    name VARCHAR(50),
    CONSTRAINT fk_food_plan FOREIGN KEY (Food_PlanId) REFERENCES Food_Plan(id),
    CONSTRAINT fk_day_food FOREIGN KEY (dayId) REFERENCES Day(id)
);

CREATE TABLE FoodTimeType (
    id INT PRIMARY KEY AUTO_INCREMENT,
    typeName VARCHAR(40) NOT NULL
);

CREATE TABLE Food_Time (
    id INT PRIMARY KEY AUTO_INCREMENT,
    foodDayId INT NOT NULL,
    foodTimeTypeId INT NOT NULL,
    CONSTRAINT fk_food_day FOREIGN KEY (foodDayId) REFERENCES Food_Day(id),
    CONSTRAINT fk_food_time_type FOREIGN KEY (foodTimeTypeId) REFERENCES FoodTimeType(id)
);

CREATE TABLE Food (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL,
    calories INT NOT NULL
);

CREATE TABLE Food_Time_Food (
    foodTimeId INT NOT NULL,
    foodId INT NOT NULL,
    PRIMARY KEY (foodTimeId, foodId),
    CONSTRAINT fk_food_time FOREIGN KEY (foodTimeId) REFERENCES Food_Time(id) ON DELETE CASCADE,
    CONSTRAINT fk_food FOREIGN KEY (foodId) REFERENCES Food(id) ON DELETE CASCADE
);
