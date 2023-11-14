'use strict';

/**
 * poster controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::poster.poster', ({ strapi }) => ({
    async findOne(ctx) {
        const { id } = ctx.params;
        const entity = await strapi.db.query('api::poster.poster').findOne({
            where: { slug: id },
            // populate: ["image_block"],
        });
        const sanitizedEntity = await this.sanitizeOutput(entity, ctx);

        return this.transformResponse(sanitizedEntity);
    }
}));
