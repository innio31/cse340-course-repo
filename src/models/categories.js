import db from './db.js';

const getAllCategories = async () => {
    const result = await db.query('SELECT * FROM category ORDER BY name');
    return result.rows;
};

const getCategoryById = async (categoryId) => {
    const query = 'SELECT category_id, name FROM category WHERE category_id = $1';
    const result = await db.query(query, [categoryId]);
    return result.rows.length > 0 ? result.rows[0] : null;
};

const getCategoriesByProjectId = async (projectId) => {
    const query = `
        SELECT c.category_id, c.name
        FROM category c
        JOIN project_category pc ON c.category_id = pc.category_id
        WHERE pc.project_id = $1
        ORDER BY c.name;
    `;
    const result = await db.query(query, [projectId]);
    return result.rows;
};

const getProjectsByCategoryId = async (categoryId) => {
    const query = `
        SELECT p.project_id, p.title
        FROM project p
        JOIN project_category pc ON p.project_id = pc.project_id
        WHERE pc.category_id = $1
        ORDER BY p.title;
    `;
    const result = await db.query(query, [categoryId]);
    return result.rows;
};

const assignCategoryToProject = async (projectId, categoryId) => {
    const query = `
        INSERT INTO project_category (project_id, category_id)
        VALUES ($1, $2)
    `;
    await db.query(query, [projectId, categoryId]);
};

const updateCategoryAssignments = async (projectId, categoryIds) => {
    // Remove all existing assignments for this project
    await db.query('DELETE FROM project_category WHERE project_id = $1', [projectId]);

    // Add the new assignments
    if (categoryIds && categoryIds.length > 0) {
        for (const categoryId of categoryIds) {
            await assignCategoryToProject(projectId, categoryId);
        }
    }
};

export {
    getAllCategories,
    getCategoryById,
    getCategoriesByProjectId,
    getProjectsByCategoryId,
    updateCategoryAssignments
};