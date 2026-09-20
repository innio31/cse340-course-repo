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

-- Insert sample organizations
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES 
    ('BrightFuture Builders', 'A nonprofit focused on building affordable housing for communities in need.', 'info@brightfuture.org', 'brightfuture-logo.png'),
    ('GreenHarvest Growers', 'An organization dedicated to sustainable farming and food security.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
    ('UnityServe Volunteers', 'Connecting volunteers with service opportunities in their community.', 'hello@unityserve.org', 'unityserve-logo.png');