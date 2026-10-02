CREATE TABLE organization (
 organization_id SERIAL PRIMARY KEY,
 name VARCHAR(150) NOT NULL,
 description TEXT NOT NULL,
 contact_email VARCHAR(255) NOT NULL,
 logo_filename VARCHAR(255) NOT NULL
 );
 INSERT INTO organization (name, description, contact_email, logo_filename)
 VALUES
 ('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
 ('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
 ('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');
 CREATE TABLE project (
 project_id SERIAL PRIMARY KEY,
 title VARCHAR(150) NOT NULL,
 description TEXT,
 location VARCHAR(150),
 organization_id INT,
 FOREIGN KEY (organization_id) REFERENCES organization(organization_id)
 );
 INSERT INTO project
 (title, description, location, organization_id)
 VALUES
 ('Community Center Renovation',
 'Renovation and improvement of an existing community center.',
 'Nairobi',
 1),

('Sustainable School Construction',
 'Construction of environmentally friendly classrooms.',
 'Kiambu',
 1),

('Rural Footbridge Project',
 'Construction of safe pedestrian footbridges for local communities.',
 'Machakos',
 1),

('Affordable Housing Initiative',
 'Development of affordable and sustainable housing units.',
 'Nakuru',
 1),

('Community Water Facility',
 'Construction of a community water facility to improve access to clean water.',
 'Kajiado',
 1),

('Community Vegetable Garden',
 'Establishment of a community vegetable garden to improve food security.',
 'Nairobi',
 2),

('Urban Farming Training',
 'Training residents on sustainable urban farming techniques.',
 'Kiambu',
 2),

('School Garden Program',
 'Creation of school gardens for agricultural and environmental education.',
 'Nakuru',
 2),

('Community Composting Project',
 'A project that converts organic household waste into useful compost.',
 'Machakos',
 2),

('Food Donation Harvest',
 'Harvesting and distributing surplus vegetables to families in need.',
 'Kajiado',
 2),

('Community Cleanup Drive',
 'Volunteers clean public spaces and promote responsible waste management.',
 'Nairobi',
 3),

('Elderly Support Program',
 'Volunteers provide assistance and support to elderly community members.',
 'Kiambu',
 3),

('School Supplies Donation',
 'Collection and distribution of school supplies to students in need.',
 'Machakos',
 3),

('Community Health Awareness',
 'Community activities promoting health, sanitation, and hygiene.',
 'Nakuru',
 3),

('Youth Mentorship Program',
 'Mentorship activities providing guidance on education and career development.',
 'Kajiado',
 3);

CREATE TABLE category (
 category_id SERIAL PRIMARY KEY,
 name VARCHAR(100) NOT NULL UNIQUE
 );

CREATE TABLE project_category (
 project_id INT NOT NULL,
 category_id INT NOT NULL,
 PRIMARY KEY (project_id, category_id),
 FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE,
 FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
 );

INSERT INTO category (name)
 VALUES ('Environmental'),
 ('Educational'),
      ('Community Service'),
      ('Health and Wellness');

INSERT INTO project_category (project_id, category_id)
 VALUES
 (1, 1),
 (2, 2),
 (3, 4);
 INSERT INTO project_category (project_id, category_id)
 VALUES
 (1, 3),
 (1, 4);    

-- ========================================
-- Roles Table
-- ========================================
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL,
    role_description TEXT
);

INSERT INTO roles (role_name, role_description) VALUES 
    ('user', 'Standard user with basic access'),
    ('admin', 'Administrator with full system access');

-- ========================================
-- Users Table
-- ========================================
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role_id INTEGER REFERENCES roles(role_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);