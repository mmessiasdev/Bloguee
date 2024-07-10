'use strict';

/**
 *  profile controller
*/

const { parseMultipartData, sanitizeEntity } = require('strapi-utils');

module.exports = {
    async createMe(ctx) {
        let entity;
        const user = ctx.state.user;
        if(!user){
            return ctx.request(null, [{messages: [{id: "Sem autorização. Header não encontrado."}]}])
        }
        if (ctx.is('multipart')) {
            const { data, files } = parseMultipartData(ctx);
            data['user'] = user;
            entity = await strapi.services.profile.create(data, { files });
        } else {
            const data = ctx.request.body;
            data['user'] = user;
            entity = await strapi.services.profile.create(ctx.request.body);
        }
        return sanitizeEntity(entity, { model: strapi.models.profile });
    },
};

// module.exports = createCoreController('api::profile.profile', ({Strapi}) => ({
//     async createMe(ctx) {
//         try {
//             const user = ctx.state.user;
//             if(!user){
//                 return ctx.badRequest(401, [{ messages: "No athorized user found!"}]);
//             }
//             const result = await strapi.entityService.create('api::profile.profile', {
//                 data: {
//                     fname: ctx.request.body.fname,
//                     lname: ctx.request.body.lname,
//                     email: user.email,
//                     user: user.id,
//                     age: ctx.request.body.age
//                 }
//             });
//             return result;
//         } catch (err){
//             return ctx.badRequest(500, [{ messages: [{ id: err.message}]}]);
//         }
//     },
//     async getMe(ctx) {
//         try {
//             const user = ctx.state.user;
//             if(!user){
//                 return ctx.badRequest(401, [{ messages: "No athorized user found!"}]);
//             }
//             const result = await strapi.db.query('api::profile.profile').findOne({
//                 where: {
//                     user: {
//                         id: {
//                             $eq: user.id
//                         }
//                     }
//                 },
//                 populate: {
//                     posters: true,
//                     chunk: true,
//                 }
//             });
//             return result;
//         } catch (err){
//             return ctx.badRequest(500, [{ messages: [{ id: 'Error'}]}]);
//         }
//     }
// }));