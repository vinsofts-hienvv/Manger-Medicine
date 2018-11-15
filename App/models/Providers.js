var mongoose = require('mongoose');

ProviderSchema = mongoose.Schema({
	providerId: {
		type: Number,
    },
    providerName: {
		type: String,
    },
    providerAddress: {
		type: String,
    },
    providerTelephone: {
		type: String,
    },
    providerOwner: {
		type: String,
    },
	created_at: {
		type: Date,
		default: ""
	},
	updated_at: {
		type: Date,
		default: ""
	}
});

const Provider = mongoose.model('Providers', ProviderSchema);


  // Export all methods
module.exports = {
    /**
     * @function  [addProvider]
     * @returns {String} Status
     */
    addProvider : (Provider, cb) => {
        Provider.create(contact, (err, provider) => {
            if(err){
                cb({status: 400, provider: {}})
            }else{
                cb({status: 200, provider: provider})
            }
        });
    },



}