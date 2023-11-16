import React from 'react'
import Button from '@mui/material/Button';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import CardContent from '@mui/material/CardContent';
import { useState } from 'react';

const ParkingOverview = () => {
    const listButton=["A1","A2","A3","A4","A5","A6"];
    const disabledd=[false,false,false,true,true,false];
    const [True,setTrue]=useState(0);
    const [False,setFalse]=useState(0);
  return (
    <>
    <div style={{marginTop:"80px",marginLeft:"5%",display:"flex",height:"85vh",flexWrap:"wrap",columnGap:"30px",maxWidth:"30vw"}}>
    {listButton.map((x,index)=>{
        return(
            <div key={x} style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",flexWrap:"wrap",MaxWidth:"5vw"}}>
            <Button sx={{width:"130px"}} variant="contained" size="large"  disabled={disabledd[index]} style={disabledd[index]?{backgroundColor:"#AF7C7B"}:{backgroundColor:"#07da63"}}>{x}</Button>
            
            </div>
        )
    })}
    </div>
    <div style={{paddingTop:"8%",display:"flex",columnGap:"4%"}}>
      
    <div class="card" style={{"width": "18rem",height:"60%"}}>
  <img class="card-img-top" src={require("./Img/CarIn.jpg")} alt="Card image cap"/><hr></hr>
  <div class="card-body">
    <p class="card-text">Number of Car Inside</p>
    <p>{`${True}`}</p>
  </div>
</div>
<div class="card" style={{"width": "18rem",height:"60%"}}>
  <img class="card-img-top" src={require("./Img/CarOutpng.png")} alt="Card Image cap" /><hr></hr>
  <div class="card-body">
  <p class="card-text">Number of Empty parking</p>
    <p>{`${False}`}</p>
</div>
    </div>
    </div>
    </>
  )
}

export default ParkingOverview
