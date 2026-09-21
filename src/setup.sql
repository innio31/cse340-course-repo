-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- Project Table
-- ========================================
CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL REFERENCES organization(organization_id),
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL
);

-- ========================================
-- Category Table
-- ========================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- ========================================
-- Project-Category Junction Table (many-to-many)
-- ========================================
CREATE TABLE project_category (
    project_id INTEGER NOT NULL REFERENCES project(project_id) ON DELETE CASCADE,
    category_id INTEGER NOT NULL REFERENCES category(category_id) ON DELETE CASCADE,
    PRIMARY KEY (project_id, category_id)
);

-- ========================================
-- Sample Data
-- ========================================

-- Organizations
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES 
    ('BrightFuture Builders', 'A nonprofit focused on building affordable housing for communities in need.', 'info@brightfuture.org', 'brightfuture-logo.png'),
    ('GreenHarvest Growers', 'An organization dedicated to sustainable farming and food security.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
    ('UnityServe Volunteers', 'Connecting volunteers with service opportunities in their community.', 'hello@unityserve.org', 'unityserve-logo.png');

-- Categories
INSERT INTO category (name)
VALUES 
    ('Environmental'),
    ('Educational'),
    ('Community Service'),
    ('Health and Wellness');

-- Projects
INSERT INTO project (organization_id, title, description, location, date)
VALUES 
    (1, 'Park Cleanup', 'Join us to clean up local parks and make them beautiful!', 'City Park', '2026-10-15'),
    (1, 'Food Drive', 'Help collect and distribute food to those in need.', 'Community Center', '2026-10-22'),
    (1, 'Community Tutoring', 'Volunteer to tutor students in various subjects.', 'Public Library', '2026-11-05'),
    (2, 'Community Garden', 'Help plant and maintain a community vegetable garden.', 'GreenHarvest Farm', '2026-10-18'),
    (2, 'Tree Planting', 'Plant trees to improve air quality and beautify the neighborhood.', 'Riverside Park', '2026-11-12'),
    (3, 'Senior Assistance', 'Assist elderly residents with daily tasks and companionship.', 'Sunrise Senior Center', '2026-10-20'),
    (3, 'Tutoring Program', 'Provide after-school tutoring for at-risk youth.', 'UnityServe Center', '2026-11-01');

-- Project-Category Relationships
INSERT INTO project_category (project_id, category_id)
VALUES 
    (1, 1), -- Park Cleanup → Environmental
    (1, 3), -- Park Cleanup → Community Service
    (2, 3), -- Food Drive → Community Service
    (2, 4), -- Food Drive → Health and Wellness
    (3, 2), -- Community Tutoring → Educational
    (4, 1), -- Community Garden → Environmental
    (5, 1), -- Tree Planting → Environmental
    (6, 3), -- Senior Assistance → Community Service
    (6, 4), -- Senior Assistance → Health and Wellness
    (7, 2); -- Tutoring Program → Educational