
CREATE DEFAULT Stat
	AS accept
cook
Ready
go



CREATE RULE Qu
	AS @col >= 1
go



CREATE RULE Salary_p
	AS @col BETWEEN 15000 AND 120000
go



CREATE RULE Paym
	AS @col >= 100
go



CREATE TABLE Category_dish
( 
	Category_id          integer  NOT NULL ,
	Category_name        char(18)  NOT NULL 
)
go



ALTER TABLE Category_dish
	ADD CONSTRAINT XPKCategory_dish PRIMARY KEY  CLUSTERED (Category_id ASC)
go



CREATE TABLE City
( 
	City_id              integer  NOT NULL ,
	City_name            char(20)  NULL 
)
go



ALTER TABLE City
	ADD CONSTRAINT XPKCity PRIMARY KEY  CLUSTERED (City_id ASC)
go



CREATE TABLE Client
( 
	Client_id            integer  NOT NULL ,
	Client_first_name    char(20)  NOT NULL ,
	Client_last_name     char(35)  NULL ,
	Client_phone         numeric  NOT NULL ,
	Client_email         char(70)  NULL ,
	Client_addres        char(50)  NULL 
)
go



ALTER TABLE Client
	ADD CONSTRAINT XPKClient PRIMARY KEY  CLUSTERED (Client_id ASC)
go



CREATE TABLE Dish_in_order
( 
	Dish_id              integer  NOT NULL ,
	Purchase_id          integer  NOT NULL ,
	Client_id            integer  NOT NULL 
)
go



ALTER TABLE Dish_in_order
	ADD CONSTRAINT XPKDish_in_order PRIMARY KEY  CLUSTERED (Dish_id ASC,Purchase_id ASC)
go



CREATE TABLE Employee
( 
	Employee_id          integer  NOT NULL ,
	Employee_first_name  char(20)  NOT NULL ,
	Employee_last_name   char(35)  NOT NULL ,
	Employee_addres      char(100)  NOT NULL ,
	Employee_phone       numeric  NOT NULL ,
	Institution_id       integer  NOT NULL ,
	Post_id              integer  NOT NULL ,
	City_id              integer  NOT NULL 
)
go



ALTER TABLE Employee
	ADD CONSTRAINT XPKEmployee PRIMARY KEY  CLUSTERED (Employee_id ASC,Post_id ASC,Institution_id ASC)
go



ALTER TABLE Employee
	ADD CONSTRAINT Phone_emp UNIQUE (Employee_phone  ASC)
go



CREATE NONCLUSTERED INDEX XIE1Employee ON Employee
( 
	Employee_last_name    ASC,
	Employee_first_name   ASC
)
go



CREATE TABLE Ingredient
( 
	Ingredient_id        integer  NOT NULL ,
	Ingredient_name      char(25)  NULL ,
	Ingredient_quantity  integer  NOT NULL ,
	Ingredient_price     money  NOT NULL ,
	Ingredient_time      integer  NULL ,
	Ingredient_del       char(25)  NULL 
)
go



ALTER TABLE Ingredient
	ADD CONSTRAINT XPKIngredient PRIMARY KEY  CLUSTERED (Ingredient_id ASC)
go



CREATE NONCLUSTERED INDEX XIE1Ingredient ON Ingredient
( 
	Ingredient_name       ASC
)
go



CREATE TABLE Ingredients_in_dish
( 
	Ingredient_id        integer  NOT NULL ,
	Dish_id              integer  NOT NULL 
)
go



ALTER TABLE Ingredients_in_dish
	ADD CONSTRAINT XPKIngredients_in_dish PRIMARY KEY  CLUSTERED (Ingredient_id ASC,Dish_id ASC)
go



CREATE TABLE Institution
( 
	Institution_id       integer  NOT NULL ,
	Institution_name     char(20)  NOT NULL ,
	Institution_addres   char(100)  NOT NULL ,
	Institution_phone    numeric  NULL ,
	City_id              integer  NOT NULL 
)
go



ALTER TABLE Institution
	ADD CONSTRAINT XPKInstitution PRIMARY KEY  CLUSTERED (Institution_id ASC,City_id ASC)
go



CREATE TABLE Menu
( 
	Dish_name            char(20)  NULL ,
	Dish_description     char(50)  NOT NULL ,
	Dish_price           money  NOT NULL ,
	Category_id          integer  NOT NULL ,
	Submission_time      datetime  NULL ,
	Dish_id              integer  NOT NULL 
)
go



ALTER TABLE Menu
	ADD CONSTRAINT XPKMenu PRIMARY KEY  CLUSTERED (Dish_id ASC)
go



CREATE NONCLUSTERED INDEX XIE1Menu ON Menu
( 
	Dish_name             ASC
)
go



CREATE TABLE Payment
( 
	Payment_id           integer  NOT NULL ,
	Payment_type         integer  NULL ,
	Payment_sum          money  NULL ,
	Payment_time         char(18)  NULL ,
	Purchase_id          integer  NOT NULL ,
	Payment_status       char(18)  NULL ,
	Client_id            integer  NOT NULL 
)
go



ALTER TABLE Payment
	ADD CONSTRAINT XPKPayment PRIMARY KEY  CLUSTERED (Payment_id ASC,Purchase_id ASC)
go



CREATE TABLE Post
( 
	Post_id              integer  NOT NULL ,
	Post_name            char(20)  NULL ,
	Post_salary          money  NOT NULL ,
	Post_work_schedule   char(20)  NULL ,
	Post_Responsibilities char(50)  NULL 
)
go



ALTER TABLE Post
	ADD CONSTRAINT XPKPost PRIMARY KEY  CLUSTERED (Post_id ASC)
go



CREATE TABLE Purchase
( 
	Purchase_id          integer  NOT NULL ,
	Purchase_date_time   DATETIME  NULL ,
	Client_id            integer  NOT NULL ,
	Employee_id          integer  NOT NULL ,
	Status_name          char(18)  NULL ,
	Post_id              integer  NOT NULL ,
	Institution_id       integer  NOT NULL 
)
go



ALTER TABLE Purchase
	ADD CONSTRAINT XPKPurchase PRIMARY KEY  CLUSTERED (Purchase_id ASC,Client_id ASC)
go



CREATE VIEW V_1(Institution_name,Institution_addres,Employee_first_name,Employee_last_name,Employee_addres,Employee_phone,Post_id,Post_salary)
AS
SELECT Institution.Institution_name,Institution.Institution_addres,Employee.Employee_first_name,Employee.Employee_last_name,Employee.Employee_addres,Employee.Employee_phone,Employee.Post_id,Post.Post_salary
	FROM Institution,Employee,Post
		WHERE Post.Post_salary>=80000
go



CREATE VIEW Dish_ingredients(Ingredient_name,Ingredient_price,Dish_price,Dish_name,Category_name)
AS
SELECT Ingredient.Ingredient_name,Ingredient.Ingredient_price,Menu.Dish_price,Menu.Dish_name,Category_dish.Category_name
	FROM Category_dish,Menu,Ingredient
go




ALTER TABLE Dish_in_order
	ADD CONSTRAINT R_50 FOREIGN KEY (Dish_id) REFERENCES Menu(Dish_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Dish_in_order
	ADD CONSTRAINT R_59 FOREIGN KEY (Purchase_id,Client_id) REFERENCES Purchase(Purchase_id,Client_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Employee
	ADD CONSTRAINT R_17 FOREIGN KEY (Institution_id,City_id) REFERENCES Institution(Institution_id,City_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Employee
	ADD CONSTRAINT R_28 FOREIGN KEY (Post_id) REFERENCES Post(Post_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




exec sp_bindrule 'Qu', 'Ingredient.Ingredient_quantity'
go




ALTER TABLE Ingredients_in_dish
	ADD CONSTRAINT R_49 FOREIGN KEY (Ingredient_id) REFERENCES Ingredient(Ingredient_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Ingredients_in_dish
	ADD CONSTRAINT R_61 FOREIGN KEY (Dish_id) REFERENCES Menu(Dish_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Institution
	ADD CONSTRAINT R_46 FOREIGN KEY (City_id) REFERENCES City(City_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Menu
	ADD CONSTRAINT R_21 FOREIGN KEY (Category_id) REFERENCES Category_dish(Category_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




exec sp_bindrule 'Paym', 'Payment.Payment_sum'
go




ALTER TABLE Payment
	ADD CONSTRAINT R_51 FOREIGN KEY (Purchase_id,Client_id) REFERENCES Purchase(Purchase_id,Client_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




exec sp_bindrule 'Salary_p', 'Post.Post_salary'
go




ALTER TABLE Purchase
	ADD CONSTRAINT R_23 FOREIGN KEY (Employee_id,Post_id,Institution_id) REFERENCES Employee(Employee_id,Post_id,Institution_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Purchase
	ADD CONSTRAINT R_22 FOREIGN KEY (Client_id) REFERENCES Client(Client_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




CREATE TRIGGER tD_Category_dish ON Category_dish FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Category_dish */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Category_dish  Menu on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000ed9e", PARENT_OWNER="", PARENT_TABLE="Category_dish"
    CHILD_OWNER="", CHILD_TABLE="Menu"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="Category_id" */
    IF EXISTS (
      SELECT * FROM deleted,Menu
      WHERE
        /*  %JoinFKPK(Menu,deleted," = "," AND") */
        Menu.Category_id = deleted.Category_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Category_dish because Menu exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Category_dish ON Category_dish FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Category_dish */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insCategory_id integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Category_dish  Menu on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0000fab0", PARENT_OWNER="", PARENT_TABLE="Category_dish"
    CHILD_OWNER="", CHILD_TABLE="Menu"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="Category_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Category_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Menu
      WHERE
        /*  %JoinFKPK(Menu,deleted," = "," AND") */
        Menu.Category_id = deleted.Category_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Category_dish because Menu exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_City ON City FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on City */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* City  Institution on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000f9ca", PARENT_OWNER="", PARENT_TABLE="City"
    CHILD_OWNER="", CHILD_TABLE="Institution"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_46", FK_COLUMNS="City_id" */
    IF EXISTS (
      SELECT * FROM deleted,Institution
      WHERE
        /*  %JoinFKPK(Institution,deleted," = "," AND") */
        Institution.City_id = deleted.City_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete City because Institution exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_City ON City FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on City */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insCity_id integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* City  Institution on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000112b4", PARENT_OWNER="", PARENT_TABLE="City"
    CHILD_OWNER="", CHILD_TABLE="Institution"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_46", FK_COLUMNS="City_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(City_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Institution
      WHERE
        /*  %JoinFKPK(Institution,deleted," = "," AND") */
        Institution.City_id = deleted.City_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update City because Institution exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Client ON Client FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Client */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Client  Purchase on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000e724", PARENT_OWNER="", PARENT_TABLE="Client"
    CHILD_OWNER="", CHILD_TABLE="Purchase"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="Client_id" */
    IF EXISTS (
      SELECT * FROM deleted,Purchase
      WHERE
        /*  %JoinFKPK(Purchase,deleted," = "," AND") */
        Purchase.Client_id = deleted.Client_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Client because Purchase exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Client ON Client FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Client */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insClient_id integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Client  Purchase on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00010ba0", PARENT_OWNER="", PARENT_TABLE="Client"
    CHILD_OWNER="", CHILD_TABLE="Purchase"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="Client_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Client_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Purchase
      WHERE
        /*  %JoinFKPK(Purchase,deleted," = "," AND") */
        Purchase.Client_id = deleted.Client_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Client because Purchase exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Dish_in_order ON Dish_in_order FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Dish_in_order */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Menu  Dish_in_order on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002858d", PARENT_OWNER="", PARENT_TABLE="Menu"
    CHILD_OWNER="", CHILD_TABLE="Dish_in_order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_50", FK_COLUMNS="Dish_id" */
    IF EXISTS (SELECT * FROM deleted,Menu
      WHERE
        /* %JoinFKPK(deleted,Menu," = "," AND") */
        deleted.Dish_id = Menu.Dish_id AND
        NOT EXISTS (
          SELECT * FROM Dish_in_order
          WHERE
            /* %JoinFKPK(Dish_in_order,Menu," = "," AND") */
            Dish_in_order.Dish_id = Menu.Dish_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Dish_in_order because Menu exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Purchase  Dish_in_order on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Purchase"
    CHILD_OWNER="", CHILD_TABLE="Dish_in_order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_59", FK_COLUMNS="Purchase_id""Client_id" */
    IF EXISTS (SELECT * FROM deleted,Purchase
      WHERE
        /* %JoinFKPK(deleted,Purchase," = "," AND") */
        deleted.Purchase_id = Purchase.Purchase_id AND
        deleted.Client_id = Purchase.Client_id AND
        NOT EXISTS (
          SELECT * FROM Dish_in_order
          WHERE
            /* %JoinFKPK(Dish_in_order,Purchase," = "," AND") */
            Dish_in_order.Purchase_id = Purchase.Purchase_id AND
            Dish_in_order.Client_id = Purchase.Client_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Dish_in_order because Purchase exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Dish_in_order ON Dish_in_order FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Dish_in_order */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insDish_id integer, 
           @insPurchase_id integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Menu  Dish_in_order on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002a633", PARENT_OWNER="", PARENT_TABLE="Menu"
    CHILD_OWNER="", CHILD_TABLE="Dish_in_order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_50", FK_COLUMNS="Dish_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Dish_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Menu
        WHERE
          /* %JoinFKPK(inserted,Menu) */
          inserted.Dish_id = Menu.Dish_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Dish_in_order because Menu does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Purchase  Dish_in_order on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Purchase"
    CHILD_OWNER="", CHILD_TABLE="Dish_in_order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_59", FK_COLUMNS="Purchase_id""Client_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Purchase_id) OR
    UPDATE(Client_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Purchase
        WHERE
          /* %JoinFKPK(inserted,Purchase) */
          inserted.Purchase_id = Purchase.Purchase_id and
          inserted.Client_id = Purchase.Client_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Dish_in_order because Purchase does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Employee ON Employee FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Employee */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Employee  Purchase on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003a8f3", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Purchase"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="Employee_id""Post_id""Institution_id" */
    IF EXISTS (
      SELECT * FROM deleted,Purchase
      WHERE
        /*  %JoinFKPK(Purchase,deleted," = "," AND") */
        Purchase.Employee_id = deleted.Employee_id AND
        Purchase.Post_id = deleted.Post_id AND
        Purchase.Institution_id = deleted.Institution_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Employee because Purchase exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Institution  Employee on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Institution"
    CHILD_OWNER="", CHILD_TABLE="Employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="Institution_id""City_id" */
    IF EXISTS (SELECT * FROM deleted,Institution
      WHERE
        /* %JoinFKPK(deleted,Institution," = "," AND") */
        deleted.Institution_id = Institution.Institution_id AND
        deleted.City_id = Institution.City_id AND
        NOT EXISTS (
          SELECT * FROM Employee
          WHERE
            /* %JoinFKPK(Employee,Institution," = "," AND") */
            Employee.Institution_id = Institution.Institution_id AND
            Employee.City_id = Institution.City_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Employee because Institution exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Post  Employee on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Post"
    CHILD_OWNER="", CHILD_TABLE="Employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="Post_id" */
    IF EXISTS (SELECT * FROM deleted,Post
      WHERE
        /* %JoinFKPK(deleted,Post," = "," AND") */
        deleted.Post_id = Post.Post_id AND
        NOT EXISTS (
          SELECT * FROM Employee
          WHERE
            /* %JoinFKPK(Employee,Post," = "," AND") */
            Employee.Post_id = Post.Post_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Employee because Post exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Employee ON Employee FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Employee */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insEmployee_id integer, 
           @insPost_id integer, 
           @insInstitution_id integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Employee  Purchase on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003f286", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Purchase"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="Employee_id""Post_id""Institution_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Employee_id) OR
    UPDATE(Post_id) OR
    UPDATE(Institution_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Purchase
      WHERE
        /*  %JoinFKPK(Purchase,deleted," = "," AND") */
        Purchase.Employee_id = deleted.Employee_id AND
        Purchase.Post_id = deleted.Post_id AND
        Purchase.Institution_id = deleted.Institution_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Employee because Purchase exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Institution  Employee on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Institution"
    CHILD_OWNER="", CHILD_TABLE="Employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="Institution_id""City_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Institution_id) OR
    UPDATE(City_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Institution
        WHERE
          /* %JoinFKPK(inserted,Institution) */
          inserted.Institution_id = Institution.Institution_id and
          inserted.City_id = Institution.City_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Employee because Institution does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Post  Employee on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Post"
    CHILD_OWNER="", CHILD_TABLE="Employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="Post_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Post_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Post
        WHERE
          /* %JoinFKPK(inserted,Post) */
          inserted.Post_id = Post.Post_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Employee because Post does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Ingredient ON Ingredient FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Ingredient */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Ingredient  Ingredients_in_dish on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00011e45", PARENT_OWNER="", PARENT_TABLE="Ingredient"
    CHILD_OWNER="", CHILD_TABLE="Ingredients_in_dish"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_49", FK_COLUMNS="Ingredient_id" */
    IF EXISTS (
      SELECT * FROM deleted,Ingredients_in_dish
      WHERE
        /*  %JoinFKPK(Ingredients_in_dish,deleted," = "," AND") */
        Ingredients_in_dish.Ingredient_id = deleted.Ingredient_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Ingredient because Ingredients_in_dish exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Ingredient ON Ingredient FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Ingredient */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insIngredient_id integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Ingredient  Ingredients_in_dish on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00012638", PARENT_OWNER="", PARENT_TABLE="Ingredient"
    CHILD_OWNER="", CHILD_TABLE="Ingredients_in_dish"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_49", FK_COLUMNS="Ingredient_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Ingredient_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Ingredients_in_dish
      WHERE
        /*  %JoinFKPK(Ingredients_in_dish,deleted," = "," AND") */
        Ingredients_in_dish.Ingredient_id = deleted.Ingredient_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Ingredient because Ingredients_in_dish exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Ingredients_in_dish ON Ingredients_in_dish FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Ingredients_in_dish */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Ingredient  Ingredients_in_dish on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00027ef3", PARENT_OWNER="", PARENT_TABLE="Ingredient"
    CHILD_OWNER="", CHILD_TABLE="Ingredients_in_dish"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_49", FK_COLUMNS="Ingredient_id" */
    IF EXISTS (SELECT * FROM deleted,Ingredient
      WHERE
        /* %JoinFKPK(deleted,Ingredient," = "," AND") */
        deleted.Ingredient_id = Ingredient.Ingredient_id AND
        NOT EXISTS (
          SELECT * FROM Ingredients_in_dish
          WHERE
            /* %JoinFKPK(Ingredients_in_dish,Ingredient," = "," AND") */
            Ingredients_in_dish.Ingredient_id = Ingredient.Ingredient_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Ingredients_in_dish because Ingredient exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Menu  Ingredients_in_dish on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Menu"
    CHILD_OWNER="", CHILD_TABLE="Ingredients_in_dish"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_61", FK_COLUMNS="Dish_id" */
    IF EXISTS (SELECT * FROM deleted,Menu
      WHERE
        /* %JoinFKPK(deleted,Menu," = "," AND") */
        deleted.Dish_id = Menu.Dish_id AND
        NOT EXISTS (
          SELECT * FROM Ingredients_in_dish
          WHERE
            /* %JoinFKPK(Ingredients_in_dish,Menu," = "," AND") */
            Ingredients_in_dish.Dish_id = Menu.Dish_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Ingredients_in_dish because Menu exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Ingredients_in_dish ON Ingredients_in_dish FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Ingredients_in_dish */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insIngredient_id integer, 
           @insDish_id integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Ingredient  Ingredients_in_dish on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002b703", PARENT_OWNER="", PARENT_TABLE="Ingredient"
    CHILD_OWNER="", CHILD_TABLE="Ingredients_in_dish"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_49", FK_COLUMNS="Ingredient_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Ingredient_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Ingredient
        WHERE
          /* %JoinFKPK(inserted,Ingredient) */
          inserted.Ingredient_id = Ingredient.Ingredient_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Ingredients_in_dish because Ingredient does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Menu  Ingredients_in_dish on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Menu"
    CHILD_OWNER="", CHILD_TABLE="Ingredients_in_dish"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_61", FK_COLUMNS="Dish_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Dish_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Menu
        WHERE
          /* %JoinFKPK(inserted,Menu) */
          inserted.Dish_id = Menu.Dish_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Ingredients_in_dish because Menu does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Institution ON Institution FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Institution */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Institution  Employee on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002205c", PARENT_OWNER="", PARENT_TABLE="Institution"
    CHILD_OWNER="", CHILD_TABLE="Employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="Institution_id""City_id" */
    IF EXISTS (
      SELECT * FROM deleted,Employee
      WHERE
        /*  %JoinFKPK(Employee,deleted," = "," AND") */
        Employee.Institution_id = deleted.Institution_id AND
        Employee.City_id = deleted.City_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Institution because Employee exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* City  Institution on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="City"
    CHILD_OWNER="", CHILD_TABLE="Institution"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_46", FK_COLUMNS="City_id" */
    IF EXISTS (SELECT * FROM deleted,City
      WHERE
        /* %JoinFKPK(deleted,City," = "," AND") */
        deleted.City_id = City.City_id AND
        NOT EXISTS (
          SELECT * FROM Institution
          WHERE
            /* %JoinFKPK(Institution,City," = "," AND") */
            Institution.City_id = City.City_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Institution because City exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Institution ON Institution FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Institution */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insInstitution_id integer, 
           @insCity_id integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Institution  Employee on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002822e", PARENT_OWNER="", PARENT_TABLE="Institution"
    CHILD_OWNER="", CHILD_TABLE="Employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="Institution_id""City_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Institution_id) OR
    UPDATE(City_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Employee
      WHERE
        /*  %JoinFKPK(Employee,deleted," = "," AND") */
        Employee.Institution_id = deleted.Institution_id AND
        Employee.City_id = deleted.City_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Institution because Employee exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* City  Institution on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="City"
    CHILD_OWNER="", CHILD_TABLE="Institution"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_46", FK_COLUMNS="City_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(City_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,City
        WHERE
          /* %JoinFKPK(inserted,City) */
          inserted.City_id = City.City_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Institution because City does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Menu ON Menu FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Menu */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Menu  Dish_in_order on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00031bbc", PARENT_OWNER="", PARENT_TABLE="Menu"
    CHILD_OWNER="", CHILD_TABLE="Dish_in_order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_50", FK_COLUMNS="Dish_id" */
    IF EXISTS (
      SELECT * FROM deleted,Dish_in_order
      WHERE
        /*  %JoinFKPK(Dish_in_order,deleted," = "," AND") */
        Dish_in_order.Dish_id = deleted.Dish_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Menu because Dish_in_order exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Menu  Ingredients_in_dish on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Menu"
    CHILD_OWNER="", CHILD_TABLE="Ingredients_in_dish"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_61", FK_COLUMNS="Dish_id" */
    IF EXISTS (
      SELECT * FROM deleted,Ingredients_in_dish
      WHERE
        /*  %JoinFKPK(Ingredients_in_dish,deleted," = "," AND") */
        Ingredients_in_dish.Dish_id = deleted.Dish_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Menu because Ingredients_in_dish exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Category_dish  Menu on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Category_dish"
    CHILD_OWNER="", CHILD_TABLE="Menu"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="Category_id" */
    IF EXISTS (SELECT * FROM deleted,Category_dish
      WHERE
        /* %JoinFKPK(deleted,Category_dish," = "," AND") */
        deleted.Category_id = Category_dish.Category_id AND
        NOT EXISTS (
          SELECT * FROM Menu
          WHERE
            /* %JoinFKPK(Menu,Category_dish," = "," AND") */
            Menu.Category_id = Category_dish.Category_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Menu because Category_dish exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Menu ON Menu FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Menu */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insDish_id integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Menu  Dish_in_order on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003769e", PARENT_OWNER="", PARENT_TABLE="Menu"
    CHILD_OWNER="", CHILD_TABLE="Dish_in_order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_50", FK_COLUMNS="Dish_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Dish_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Dish_in_order
      WHERE
        /*  %JoinFKPK(Dish_in_order,deleted," = "," AND") */
        Dish_in_order.Dish_id = deleted.Dish_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Menu because Dish_in_order exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Menu  Ingredients_in_dish on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Menu"
    CHILD_OWNER="", CHILD_TABLE="Ingredients_in_dish"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_61", FK_COLUMNS="Dish_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Dish_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Ingredients_in_dish
      WHERE
        /*  %JoinFKPK(Ingredients_in_dish,deleted," = "," AND") */
        Ingredients_in_dish.Dish_id = deleted.Dish_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Menu because Ingredients_in_dish exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Category_dish  Menu on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Category_dish"
    CHILD_OWNER="", CHILD_TABLE="Menu"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="Category_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Category_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Category_dish
        WHERE
          /* %JoinFKPK(inserted,Category_dish) */
          inserted.Category_id = Category_dish.Category_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Menu because Category_dish does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Payment ON Payment FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Payment */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Purchase  Payment on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00015bf8", PARENT_OWNER="", PARENT_TABLE="Purchase"
    CHILD_OWNER="", CHILD_TABLE="Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_51", FK_COLUMNS="Purchase_id""Client_id" */
    IF EXISTS (SELECT * FROM deleted,Purchase
      WHERE
        /* %JoinFKPK(deleted,Purchase," = "," AND") */
        deleted.Purchase_id = Purchase.Purchase_id AND
        deleted.Client_id = Purchase.Client_id AND
        NOT EXISTS (
          SELECT * FROM Payment
          WHERE
            /* %JoinFKPK(Payment,Purchase," = "," AND") */
            Payment.Purchase_id = Purchase.Purchase_id AND
            Payment.Client_id = Purchase.Client_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Payment because Purchase exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Payment ON Payment FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Payment */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insPayment_id integer, 
           @insPurchase_id integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Purchase  Payment on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00017807", PARENT_OWNER="", PARENT_TABLE="Purchase"
    CHILD_OWNER="", CHILD_TABLE="Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_51", FK_COLUMNS="Purchase_id""Client_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Purchase_id) OR
    UPDATE(Client_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Purchase
        WHERE
          /* %JoinFKPK(inserted,Purchase) */
          inserted.Purchase_id = Purchase.Purchase_id and
          inserted.Client_id = Purchase.Client_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Payment because Purchase does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Post ON Post FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Post */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Post  Employee on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000ddf5", PARENT_OWNER="", PARENT_TABLE="Post"
    CHILD_OWNER="", CHILD_TABLE="Employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="Post_id" */
    IF EXISTS (
      SELECT * FROM deleted,Employee
      WHERE
        /*  %JoinFKPK(Employee,deleted," = "," AND") */
        Employee.Post_id = deleted.Post_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Post because Employee exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Post ON Post FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Post */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insPost_id integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Post  Employee on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0000fd9c", PARENT_OWNER="", PARENT_TABLE="Post"
    CHILD_OWNER="", CHILD_TABLE="Employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="Post_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Post_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Employee
      WHERE
        /*  %JoinFKPK(Employee,deleted," = "," AND") */
        Employee.Post_id = deleted.Post_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Post because Employee exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Purchase ON Purchase FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Purchase */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Purchase  Payment on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0004b247", PARENT_OWNER="", PARENT_TABLE="Purchase"
    CHILD_OWNER="", CHILD_TABLE="Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_51", FK_COLUMNS="Purchase_id""Client_id" */
    IF EXISTS (
      SELECT * FROM deleted,Payment
      WHERE
        /*  %JoinFKPK(Payment,deleted," = "," AND") */
        Payment.Purchase_id = deleted.Purchase_id AND
        Payment.Client_id = deleted.Client_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Purchase because Payment exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Purchase  Dish_in_order on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Purchase"
    CHILD_OWNER="", CHILD_TABLE="Dish_in_order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_59", FK_COLUMNS="Purchase_id""Client_id" */
    IF EXISTS (
      SELECT * FROM deleted,Dish_in_order
      WHERE
        /*  %JoinFKPK(Dish_in_order,deleted," = "," AND") */
        Dish_in_order.Purchase_id = deleted.Purchase_id AND
        Dish_in_order.Client_id = deleted.Client_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Purchase because Dish_in_order exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Client  Purchase on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Client"
    CHILD_OWNER="", CHILD_TABLE="Purchase"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="Client_id" */
    IF EXISTS (SELECT * FROM deleted,Client
      WHERE
        /* %JoinFKPK(deleted,Client," = "," AND") */
        deleted.Client_id = Client.Client_id AND
        NOT EXISTS (
          SELECT * FROM Purchase
          WHERE
            /* %JoinFKPK(Purchase,Client," = "," AND") */
            Purchase.Client_id = Client.Client_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Purchase because Client exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Employee  Purchase on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Purchase"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="Employee_id""Post_id""Institution_id" */
    IF EXISTS (SELECT * FROM deleted,Employee
      WHERE
        /* %JoinFKPK(deleted,Employee," = "," AND") */
        deleted.Employee_id = Employee.Employee_id AND
        deleted.Post_id = Employee.Post_id AND
        deleted.Institution_id = Employee.Institution_id AND
        NOT EXISTS (
          SELECT * FROM Purchase
          WHERE
            /* %JoinFKPK(Purchase,Employee," = "," AND") */
            Purchase.Employee_id = Employee.Employee_id AND
            Purchase.Post_id = Employee.Post_id AND
            Purchase.Institution_id = Employee.Institution_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Purchase because Employee exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Purchase ON Purchase FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Purchase */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insPurchase_id integer, 
           @insClient_id integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Purchase  Payment on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00053f13", PARENT_OWNER="", PARENT_TABLE="Purchase"
    CHILD_OWNER="", CHILD_TABLE="Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_51", FK_COLUMNS="Purchase_id""Client_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Purchase_id) OR
    UPDATE(Client_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Payment
      WHERE
        /*  %JoinFKPK(Payment,deleted," = "," AND") */
        Payment.Purchase_id = deleted.Purchase_id AND
        Payment.Client_id = deleted.Client_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Purchase because Payment exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Purchase  Dish_in_order on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Purchase"
    CHILD_OWNER="", CHILD_TABLE="Dish_in_order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_59", FK_COLUMNS="Purchase_id""Client_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Purchase_id) OR
    UPDATE(Client_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Dish_in_order
      WHERE
        /*  %JoinFKPK(Dish_in_order,deleted," = "," AND") */
        Dish_in_order.Purchase_id = deleted.Purchase_id AND
        Dish_in_order.Client_id = deleted.Client_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Purchase because Dish_in_order exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Client  Purchase on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Client"
    CHILD_OWNER="", CHILD_TABLE="Purchase"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="Client_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Client_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Client
        WHERE
          /* %JoinFKPK(inserted,Client) */
          inserted.Client_id = Client.Client_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Purchase because Client does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Employee  Purchase on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Purchase"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="Employee_id""Post_id""Institution_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Employee_id) OR
    UPDATE(Post_id) OR
    UPDATE(Institution_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Employee
        WHERE
          /* %JoinFKPK(inserted,Employee) */
          inserted.Employee_id = Employee.Employee_id and
          inserted.Post_id = Employee.Post_id and
          inserted.Institution_id = Employee.Institution_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Purchase because Employee does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


