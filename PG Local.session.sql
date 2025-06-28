-- --   CREATE TABLE tutorial_data (
-- --     drug_name TEXT,
-- --     side_effect TEXT,
-- --     side_effect_1 TEXT,
-- --     side_effect_2 TEXT,
-- --     side_effect_3 TEXT,
-- --     side_effect_4 TEXT,
-- --     interacts_with TEXT,
-- --     interacts_with_1 TEXT,
-- --     interacts_with_2 TEXT,
-- --     disease_name TEXT,
-- --     disease_category TEXT,
-- --     drug_category TEXT,
-- --     product_name TEXT,
-- --     company_name TEXT,
-- --     clinical_trial_title TEXT,
-- --     clinical_trial_start_date TEXT,
-- --     clinical_trial_completion_date TEXT,
-- --     clinical_trial_participants FLOAT,
-- --     clinical_trial_status TEXT,
-- --     clinical_trial_condition TEXT,
-- --     clinical_trial_condition_1 TEXT,
-- --     clinical_trial_address TEXT,
-- --     clinical_trial_institution TEXT,
-- --     clinical_trial_address_1 TEXT,
-- --     clinical_trial_main_researcher TEXT,
-- --     clinical_trial_condition_2 TEXT
-- -- );
  
  
-- -- -- Table for Drug Entity
--  CREATE TABLE Drug (
--      drug_name VARCHAR(255) PRIMARY KEY,
--      drug_category VARCHAR(100),
--      product_name VARCHAR(255),
--      company_name VARCHAR(255)
--  );

-- -- -- Table for SideEffect Entity
--  CREATE TABLE SideEffect (
--      name VARCHAR(255) PRIMARY KEY
--  );

-- -- -- Table for Interaction Entity
--  CREATE TABLE Interaction (
--      name VARCHAR(255) PRIMARY KEY
--  );

-- -- -- Table for Disease Entity
--  CREATE TABLE Disease (
--      disease_name VARCHAR(255) PRIMARY KEY,
--      disease_category VARCHAR(100)
--  );

-- -- -- Table for ClinicalTrial Entity (dates as TEXT now)
--  CREATE TABLE ClinicalTrial (
--      clinical_trial_title VARCHAR(500) PRIMARY KEY,
--      clinical_trial_start_date TEXT,
--      clinical_trial_completion_date TEXT,
--      clinical_trial_participants NUMERIC,
--      clinical_trial_status VARCHAR(50),
--      clinical_trial_address VARCHAR(500),
--      clinical_trial_institution VARCHAR(255),
--      clinical_trial_address_1 VARCHAR(500),
--      clinical_trial_main_researcher VARCHAR(255)
-- );

-- -- -- Table for ClinicalTrialCondition Entity
--  CREATE TABLE ClinicalTrialCondition (
--      name VARCHAR(255) PRIMARY KEY
--  );

-- -- -- Junction Table for Drug-SideEffect relationship
--  CREATE TABLE Drug_SideEffect (
--      drug_name VARCHAR(255) REFERENCES Drug(drug_name) ON DELETE CASCADE,
--      side_effect_name VARCHAR(255) REFERENCES SideEffect(name) ON DELETE CASCADE,
--      PRIMARY KEY (drug_name, side_effect_name)
--  );

-- -- -- Junction Table for Drug-Interaction relationship
--  CREATE TABLE Drug_Interaction (
--      drug_name VARCHAR(255) REFERENCES Drug(drug_name) ON DELETE CASCADE,
--      interaction_name VARCHAR(255) REFERENCES Interaction(name) ON DELETE CASCADE,
--      PRIMARY KEY (drug_name, interaction_name)
--  );

-- -- -- Junction Table for Drug-Disease relationship
--  CREATE TABLE Drug_Disease (     
--     drug_name VARCHAR(255) REFERENCES Drug(drug_name) ON DELETE CASCADE,
--      disease_name VARCHAR(255) REFERENCES Disease(disease_name) ON DELETE CASCADE,
--      PRIMARY KEY (drug_name, disease_name)
--  );

-- -- -- Junction Table for Drug-ClinicalTrial relationship
--  CREATE TABLE Drug_ClinicalTrial (
--      drug_name VARCHAR(255) REFERENCES Drug(drug_name) ON DELETE CASCADE,
--    clinical_trial_title VARCHAR(500) REFERENCES ClinicalTrial(clinical_trial_title) ON DELETE CASCADE,
--    PRIMARY KEY (drug_name, clinical_trial_title)
-- );

-- -- -- Junction Table for ClinicalTrial-Condition relationship
--  CREATE TABLE ClinicalTrial_Condition (
--     clinical_trial_title VARCHAR(500) REFERENCES ClinicalTrial(clinical_trial_title) ON DELETE CASCADE,
--     condition_name VARCHAR(255) REFERENCES ClinicalTrialCondition(name) ON DELETE CASCADE,
--     PRIMARY KEY (clinical_trial_title, condition_name)
--  );


-- -- Insert into Drug
-- INSERT INTO Drug (drug_name, drug_category, product_name, company_name)
-- SELECT DISTINCT
--        drug_name,
--        drug_category,
--        product_name,
--        company_name
-- FROM tutorial_data
-- WHERE drug_name IS NOT NULL
-- ON CONFLICT (drug_name) DO NOTHING;

-- -- Insert into SideEffect
-- INSERT INTO SideEffect (name)
-- SELECT DISTINCT TRIM(val) AS name
-- FROM tutorial_data,
--      LATERAL UNNEST(ARRAY[
--          side_effect,
--          side_effect_1,
--          side_effect_2,
--          side_effect_3,
--          side_effect_4
--      ]) AS val
-- WHERE val IS NOT NULL
--   AND TRIM(val) <> ''
-- ON CONFLICT (name) DO NOTHING;

-- -- Insert into Interaction
-- INSERT INTO Interaction (name)
-- SELECT DISTINCT TRIM(val) AS name
-- FROM tutorial_data,
--      LATERAL UNNEST(ARRAY[
--          interacts_with,
--          interacts_with_1,
--          interacts_with_2
--      ]) AS val
-- WHERE val IS NOT NULL
--   AND TRIM(val) <> ''
-- ON CONFLICT (name) DO NOTHING;

-- -- Insert into Disease
-- INSERT INTO Disease (disease_name, disease_category)
-- SELECT DISTINCT
--        disease_name,
--        disease_category
-- FROM tutorial_data
-- WHERE disease_name IS NOT NULL
-- ON CONFLICT (disease_name) DO NOTHING;

-- -- Insert into ClinicalTrial
-- INSERT INTO ClinicalTrial (
--     clinical_trial_title,
--     clinical_trial_start_date,
--     clinical_trial_completion_date,
--     clinical_trial_participants,
--     clinical_trial_status,
--     clinical_trial_address,
--     clinical_trial_institution,
--     clinical_trial_address_1,
--     clinical_trial_main_researcher
-- )
-- SELECT DISTINCT
--        clinical_trial_title,
--        clinical_trial_start_date,
--        clinical_trial_completion_date,
--        clinical_trial_participants,
--        clinical_trial_status,
--        clinical_trial_address,
--        clinical_trial_institution,
--        clinical_trial_address_1,
--        clinical_trial_main_researcher
-- FROM tutorial_data
-- WHERE clinical_trial_title IS NOT NULL
-- ON CONFLICT (clinical_trial_title) DO NOTHING;

-- -- Insert into ClinicalTrialCondition
-- INSERT INTO ClinicalTrialCondition (name)
-- SELECT DISTINCT TRIM(val) AS name
-- FROM tutorial_data,
--      LATERAL UNNEST(ARRAY[
--          clinical_trial_condition,
--          clinical_trial_condition_1,
--          clinical_trial_condition_2
--      ]) AS val
-- WHERE val IS NOT NULL
--   AND TRIM(val) <> ''
-- ON CONFLICT (name) DO NOTHING;

-- -- Insert into Drug_SideEffect
-- INSERT INTO Drug_SideEffect (drug_name, side_effect_name)
-- SELECT DISTINCT
--        drug_name,
--        TRIM(val) AS side_effect_name
-- FROM tutorial_data,
--      LATERAL UNNEST(ARRAY[
--          side_effect,
--          side_effect_1,
--          side_effect_2,
--          side_effect_3,
--          side_effect_4
--      ]) AS val
-- WHERE drug_name IS NOT NULL
--   AND val IS NOT NULL
--   AND TRIM(val) <> ''
-- ON CONFLICT (drug_name, side_effect_name) DO NOTHING;

-- -- Insert into Drug_Interaction
-- INSERT INTO Drug_Interaction (drug_name, interaction_name)
-- SELECT DISTINCT
--        drug_name,
--        TRIM(val) AS interaction_name
-- FROM tutorial_data,
--      LATERAL UNNEST(ARRAY[
--          interacts_with,
--          interacts_with_1,
--          interacts_with_2
--      ]) AS val
-- WHERE drug_name IS NOT NULL
--   AND val IS NOT NULL
--   AND TRIM(val) <> ''
-- ON CONFLICT (drug_name, interaction_name) DO NOTHING;

-- -- Insert into Drug_Disease
-- INSERT INTO Drug_Disease (drug_name, disease_name)
-- SELECT DISTINCT
--        drug_name,
--        disease_name
-- FROM tutorial_data
-- WHERE drug_name IS NOT NULL
--   AND disease_name IS NOT NULL
-- ON CONFLICT (drug_name, disease_name) DO NOTHING;

-- -- Insert into Drug_ClinicalTrial
-- INSERT INTO Drug_ClinicalTrial (drug_name, clinical_trial_title)
-- SELECT DISTINCT
--        drug_name,
--        clinical_trial_title
-- FROM tutorial_data
-- WHERE drug_name IS NOT NULL
--   AND clinical_trial_title IS NOT NULL
-- ON CONFLICT (drug_name, clinical_trial_title) DO NOTHING;

-- -- Insert into ClinicalTrial_Condition
-- INSERT INTO ClinicalTrial_Condition (clinical_trial_title, condition_name)
-- SELECT DISTINCT
--        clinical_trial_title,
--        TRIM(val) AS condition_name
-- FROM tutorial_data,
--      LATERAL UNNEST(ARRAY[
--          clinical_trial_condition,
--          clinical_trial_condition_1,
--          clinical_trial_condition_2
--      ]) AS val
-- WHERE clinical_trial_title IS NOT NULL
--   AND val IS NOT NULL
--   AND TRIM(val) <> ''
-- ON CONFLICT (clinical_trial_title, condition_name) DO NOTHING;

--quary
--a

SELECT COUNT(DISTINCT drug_name) AS drug_count
FROM Drug_SideEffect
WHERE side_effect_name ILIKE 'nausea';

--b
SELECT DISTINCT drug_name
 FROM Drug_Interaction
 WHERE interaction_name ILIKE 'butabarbital';

--c
SELECT drug_name
 FROM Drug_SideEffect
 WHERE side_effect_name ILIKE 'cough'
 INTERSECT
 SELECT drug_name
 FROM Drug_SideEffect
 
 WHERE side_effect_name ILIKE 'headache'; 

--d
SELECT DISTINCT drug_name
 FROM Drug_Disease
 JOIN Disease USING ( disease_name )
 WHERE disease_category LIKE  'endocrine';

--e
SELECT drug_name
 FROM Drug_Disease
 JOIN Disease USING ( disease_name )
 WHERE disease_category ILIKE 'immunological'
 AND drug_name NOT IN (
 SELECT drug_name
 FROM Drug_Disease
 JOIN Disease USING ( disease_name )
 WHERE disease_category ILIKE 'hematological'
 )
 GROUP BY drug_name
 ORDER BY COUNT (*) DESC
 LIMIT 1;

 --f
 SELECT disease_name
 FROM Drug_Disease
 WHERE drug_name ILIKE 'hydrocortisone'
 EXCEPT
 SELECT disease_name
 FROM Drug_Disease
 WHERE drug_name ILIKE 'etanercept';

 --g
 SELECT side_effect_name , COUNT (*) AS freq
 FROM Drug_SideEffect
 WHERE drug_name IN (
 SELECT drug_name
 FROM Drug_Disease
 JOIN Disease USING ( disease_name )
 WHERE disease_name ILIKE '% asthma %'
 )
 AND drug_name NOT IN (
 SELECT drug_name
 FROM Drug_Disease
 JOIN Disease USING ( disease_name )
 WHERE disease_category ILIKE 'hematological'
 )
 GROUP BY side_effect_name
 ORDER BY freq DESC
 LIMIT 10;