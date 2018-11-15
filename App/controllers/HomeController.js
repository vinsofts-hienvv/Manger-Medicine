module.exports = {
    homePage: (req, res) => { // arrow function
        res.render('index', { title: 'Medicine trade' });
    },

    adminPage: (req, res) => {
        res.render('admin', {title: 'Admin'})
    }
}