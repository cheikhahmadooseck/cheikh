/* jshint esversion: 6 */
/* jshint esversion: 8 */
/* jshint node: true */



const express = require("express");
const router = express.Router();
const auth = require("../middleware/auth");
const multer  = require('multer');
const mysql = require("mysql2");
const sendOneNotification = require("../middleware/send");
const { DataFind, DataInsert, DataUpdate, DataDelete } = require("../middleware/databse_query");




async function DailyReport(where) {
    const all = await DataFind(`SELECT
                                    COUNT(*) AS today,
                                    COALESCE(SUM(CASE WHEN status = '1' THEN 1 ELSE 0 END), 0) AS accept,
                                    COALESCE(SUM(CASE WHEN status = '2' THEN 1 ELSE 0 END), 0) AS iamhere,
                                    COALESCE(SUM(CASE WHEN status = '3' THEN 1 ELSE 0 END), 0) AS enterotp,
                                    COALESCE(SUM(CASE WHEN status = '4' THEN 1 ELSE 0 END), 0) AS cancel,
                                    COALESCE(SUM(CASE WHEN status = '5' THEN 1 ELSE 0 END), 0) AS start,
                                    COALESCE(SUM(CASE WHEN status = '6' THEN 1 ELSE 0 END), 0) AS end,
                                    COALESCE(SUM(CASE WHEN status = '7' THEN 1 ELSE 0 END), 0) AS ridecomplete,
                                    COALESCE(SUM(CASE WHEN status = '8' THEN 1 ELSE 0 END), 0) AS complete
                                FROM tbl_cart_vehicle ${where}`);

    const com = await DataFind(`SELECT
                                    COUNT(*) AS today,
                                    COALESCE(SUM(CASE WHEN status = '1' THEN 1 ELSE 0 END), 0) AS accept,
                                    COALESCE(SUM(CASE WHEN status = '2' THEN 1 ELSE 0 END), 0) AS iamhere,
                                    COALESCE(SUM(CASE WHEN status = '3' THEN 1 ELSE 0 END), 0) AS enterotp,
                                    COALESCE(SUM(CASE WHEN status = '4' THEN 1 ELSE 0 END), 0) AS cancel,
                                    COALESCE(SUM(CASE WHEN status = '5' THEN 1 ELSE 0 END), 0) AS start,
                                    COALESCE(SUM(CASE WHEN status = '6' THEN 1 ELSE 0 END), 0) AS end,
                                    COALESCE(SUM(CASE WHEN status = '7' THEN 1 ELSE 0 END), 0) AS ridecomplete,
                                    COALESCE(SUM(CASE WHEN status = '8' THEN 1 ELSE 0 END), 0) AS complete
                                FROM tbl_order_vehicle ${where}`);
    
    let allstatus = [{ total: parseFloat(all[0].today) + parseFloat(com[0].today) }, { accept: parseFloat(all[0].accept) + parseFloat(com[0].accept) }, 
                    { iamhere: parseFloat(all[0].iamhere) + parseFloat(com[0].iamhere) }, { enterotp: parseFloat(all[0].enterotp) + parseFloat(com[0].enterotp) }, 
                    { cancel: parseFloat(all[0].cancel) + parseFloat(com[0].cancel) }, { start: parseFloat(all[0].start) + parseFloat(com[0].start) }, 
                    { end: parseFloat(all[0].end) + parseFloat(com[0].end) }, { ridecomplete: parseFloat(all[0].ridecomplete) + parseFloat(com[0].ridecomplete) }, 
                    { complete: parseFloat(all[0].complete) + parseFloat(com[0].complete) }];
    return allstatus;
}

router.get("/vehicle_daily", auth, async(req, res)=>{
    try {
        const driver = await DataFind(`SELECT * FROM tbl_driver ORDER BY id DESC`);
        let today = new Date().toISOString().split("T")[0];
        let daily_list = await DailyReport(`WHERE start_time LIKE '%${today}%'`);
        
        res.render("report_vehicle_daily", {
            auth:req.user, general:req.general, noti:req.notification, per:req.per, lan:req.lan.ld, land:req.lan.lname, driver, daily_list, today
        })
    } catch (error) {
        console.log(error);
    }
})

router.post("/daily_data", auth, async(req, res)=>{
    try {
        let {date, sid} = req.body;

        let where = "", daily_list = "";
        if (date && sid) {
            where = `WHERE start_time LIKE '%${date}%' AND d_id = "${sid}"`;
            daily_list = await DailyReport(where);

        } else if (date) {
            where = `WHERE start_time LIKE '%${date}%'`;
            daily_list = await DailyReport(where);
            
        } else if(sid) {
            where = `WHERE d_id = "${sid}"`;
            daily_list = await DailyReport(where);
        }

        res.send({ daily_list });
    } catch (error) {
        console.log(error);
    }
})



module.exports = router;