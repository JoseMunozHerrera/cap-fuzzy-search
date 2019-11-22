/* eslint-disable no-undef */
"use strict";
module.exports = function () {

    this.on("READ", "Regions", async (req, next) => {
        if (req._.query) {
            if (Object.prototype.hasOwnProperty.call(req._.query, '$search')) {
                if (!req.query.SELECT.columns[0].func) {
                    req.query.SELECT.columns.push({ "ref": ["TO_DECIMAL(SCORE(),3,2)"], "as": "score" })
                    req.query.SELECT.columns.push({ "ref": ["TO_NVARCHAR(HIGHLIGHTED (NAME))"], "as": "descriptionSnippet" })
                    for (let arg of req.query.SELECT.where[0].args) {
                        if (arg.func) {
                            arg.args[0].val = 0.7  //Set Fuzziness
                            arg.args[1].val = 'similarCalculationMode=Symmetricsearch'
                        }
                    }
                }
            }
        }
        return next()
    })

}    