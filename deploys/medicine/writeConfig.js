const fs = require('fs');

module.exports = {
    writeConfig: function writeConfig(httpProvider, addressContract, abiContract) {
        // httpProvider
        fs.writeFileSync('../../contracts/betting/config.js', 'const httpProvider="' + httpProvider + '";\n\nconst addressContract="' + addressContract + '";\n\nconst abiContract =' + abiContract + ';\n\nmodule.exports = {httpProvider, addressContract, abiContract}', (err) => {
            if (err)
                console.log('Error!');
        });
    }
}