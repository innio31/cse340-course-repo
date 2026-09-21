import db from './db.js';

const getAllProjects = async () => {
    const result = await db.query('SELECT * FROM project ORDER BY date');
    return result.rows;
};

const getProjectsByOrganizationId = async (organizationId) => {
    const query = `
        SELECT project_id, organization_id, title, description, location, date
        FROM project
        WHERE organization_id = $1
        ORDER BY date;
    `;
    const result = await db.query(query, [organizationId]);
    return result.rows;
};

const getProjectDetails = async (projectId) => {
    const query = `
        SELECT p.project_id, p.title, p.description, p.location, p.date,
               o.organization_id, o.name AS organization_name
        FROM project p
        JOIN organization o ON p.organization_id = o.organization_id
        WHERE p.project_id = $1;
    `;
    const result = await db.query(query, [projectId]);
    return result.rows.length > 0 ? result.rows[0] : null;
};

const getUpcomingProjects = async (limit = 5) => {
    const query = `
        SELECT p.project_id, p.title, p.date,
               o.organization_id, o.name AS organization_name
        FROM project p
        JOIN organization o ON p.organization_id = o.organization_id
        WHERE p.date >= CURRENT_DATE
        ORDER BY p.date
        LIMIT $1;
    `;
    const result = await db.query(query, [limit]);
    return result.rows;
};

// Export the model functions
export { getAllProjects, getProjectsByOrganizationId, getProjectDetails, getUpcomingProjects };