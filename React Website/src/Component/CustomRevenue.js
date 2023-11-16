import React from 'react'
import { useEffect, useState } from 'react';
import { ref, onValue, child } from "firebase/database"
import StartFirebase from "../firebase"
import { collection, getDocs ,db} from 'firebase/firestore';


const CustomRevenue = (props) => {
    const numbers = [props.totalamnt, 6 - props.Filled, props.Filled, props.checkedout];


    return (
        <div style={{ paddingTop: "5%" }}>
            <div style={{ display: "flex", columnGap: "8%", paddingLeft: "6%" }}>
                <div style={{ display: "flex", background: "#F9D8DD", width: "40%", columnGap: "20px", justifyContent: "space-around", borderRadius: "15px", height: "23vh", boxShadow: "rgba(254, 205, 211, 0.1) 0px 4px 16px, rgba(254,205,211,0.1) 0px 8px 24px, rgba(254,205,211, 0.1) 0px 16px 56px" }}>
                    <div style={{ background: "#DF3D56", height: "50%", marginTop: "30px", borderRadius: "10px", width: "20%" }}>
                        <img src={require('./Img/car(2) 4.png')} style={{ width: "70px", height: "70px" }} />
                    </div>
                    <div>
                        <h1 style={{ fontSize: "70px" }}>&#x20B9; {numbers[0]}</h1>
                        <h4>Total Revenue</h4>
                    </div>
                </div>
                <div style={{ display: "flex", background: "#FFF5DC", width: "40%", columnGap: "20px", justifyContent: "space-around", borderRadius: "15px", height: "23vh", boxShadow: "rgba(254, 205, 211, 0.1) 0px 4px 16px, rgba(254,205,211,0.1) 0px 8px 24px, rgba(254,205,211, 0.1) 0px 16px 56px" }}>
                    <div style={{ background: "#FFCB51", height: "50%", marginTop: "30px", borderRadius: "10px", width: "20%" }}>
                        <img src={require('./Img/car(2) 4.png')} style={{ width: "70px", height: "70px" }} />
                    </div>
                    <div>
                        <h1 style={{ fontSize: "70px" }}>{numbers[1]}</h1>
                        <h4>Vacant Slots</h4>
                    </div>
                </div>
            </div>
            <div style={{ display: "flex", columnGap: "5%", justifyContent: "space-around", paddingTop: "10%" }}>
                <div style={{ display: "flex", background: "#FDE2DB", width: "27%", columnGap: "20px", justifyContent: "space-around", borderRadius: "15px", height: "23vh", boxShadow: "rgba(254, 205, 211, 0.1) 0px 4px 16px, rgba(254,205,211,0.1) 0px 8px 24px, rgba(254,205,211, 0.1) 0px 16px 56px" }}>
                    <div style={{ background: "#F6A67A", height: "40%", marginTop: "40px", borderRadius: "10px", width: "20%", marginLeft: "3%" }}>
                        <img src={require('./Img/car(2) 4.png')} style={{ width: "50px", height: "50px" }} />
                    </div>
                    <div>
                        <h1 style={{ fontSize: "70px" }}>{numbers[2]}</h1>
                        <h4 style={{ marginTop: "-10px", width: "60%", marginLeft: "20%" }}>Cars currently checked in</h4>
                    </div>
                </div>
                <div style={{ display: "flex", background: "#FFEBDA", width: "25%", columnGap: "20px", justifyContent: "space-around", borderRadius: "15px", height: "23vh", boxShadow: "rgba(254, 205, 211, 0.1) 0px 4px 16px, rgba(254,205,211,0.1) 0px 8px 24px, rgba(254,205,211, 0.1) 0px 16px 56px" }}>
                    <div style={{ background: "#FFC390", height: "40%", marginTop: "40px", borderRadius: "10px", width: "20%" }}>
                        <img src={require('./Img/car(2) 4.png')} style={{ width: "50px", height: "50px" }} />
                    </div>
                    <div>
                        <h1 style={{ fontSize: "70px" }}>{numbers[3]}</h1>
                        <h4>Cars checked out</h4>
                    </div>
                </div>
                
            </div>
        </div>
    )
}

export default CustomRevenue
