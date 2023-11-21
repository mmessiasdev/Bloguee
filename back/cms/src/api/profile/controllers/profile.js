'use strict';

/**
 *  profile controller
*/

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::profile.profile', ({Strapi}) => ({
    async createMe(ctx) {
        try {
            const user = ctx.state.user;
            if(!user){
                return ctx.badRequest(401, [{ messages: "No athorized user found!"}]);
            }
            const result = await strapi.entityService.create('api::profile.profile', {
                data: {
                    fname: ctx.request.body.fname,
                    lname: ctx.request.body.lname,
                    email: user.email,
                    user: user.id,
                    age: ctx.request.body.age
                }
            });
            return result;
        } catch (err){
            return ctx.badRequest(500, [{ messages: [{ id: err.message}]}]);
        }
    },
    async getMe(ctx) {
        try {
            const user = ctx.state.user;
            if(!user){
                return ctx.badRequest(401, [{ messages: "No athorized user found!"}]);
            }
            const result = await strapi.db.query('api::profile.profile').findOne({
                where: {
                    user: {
                        id: {
                            $eq: user.id
                        }
                    }
                },
                populate: {
                    image: true,
                    post: true
                }
            });
            return result;
        } catch (err){
            return ctx.badRequest(500, [{ messages: [{ id: 'Error'}]}]);
        }
    }
}));