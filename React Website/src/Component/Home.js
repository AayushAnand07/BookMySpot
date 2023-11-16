import React from 'react'
import { useEffect, useState, useRef } from "react";
import { TimelineLite, TweenMax, Power3 } from "gsap";
import heroimg from "./Img/car4.jpg";
import heroimg2 from "./Img/carr.jpg";
import heroimg3 from "./Img/Home.jpg"
const Home = (props) => {
    let tl = new TimelineLite({ delay: 0.2 });
    const [index, setIndex] = useState(0);
    const [img, setImg] = useState("");
    const [heading,setHeading]=React.useState("The parking system will recognize the license plate of the vehicle with help of mini cameras installed at the lot and allow the driver to enter the parking lot without the need for any physical parking ticket.");
    const headingArr=[
      "The parking system will recognize the license plate of the vehicle with help of mini cameras installed at the lot and allow the driver to enter the parking lot without the need for any physical parking ticket.",
      "The information captured by the sensors is transmitted to a cloud-based server, where it is processed and analyzed to determine the availability of parking spots.",
      "The information is then made available to drivers through a mobile app, which shows the real-time availability of parking spots in the particular place.",
      "Drivers can use the mobile app to search for available parking spots and reserve a spot in advance."
    ];
    const imgArr = [heroimg, heroimg2, heroimg3];
   
    useEffect(() => {
      setHeading(headingArr[index]);
      setImg(imgArr[index]);
      const headlineFirst = document.getElementById("headline");
      const contentImg = document.getElementById("content-img");
      tl.from(contentImg, 0.5, {
        opacity: 0,
        ease: Power3.easeOut,
      })
      tl.from(headlineFirst, 0.5, {
        opacity: 0,
        y: -20,
        ease: Power3.easeOut,
      })
    }, [index]);
    useEffect(() => {
      const interval = setInterval(() => {
        const contentImg = document.getElementById("content-img");
        const headlineFirst = document.getElementById("headline");
        tl.to(contentImg, 0.5, {
          opacity: 0,
          ease: Power3.easeOut,
        });
        tl.to(headlineFirst, 0.5, {
          opacity: 0,
          ease: Power3.easeOut,
        });
        setIndex((index) => (index + 1) % 3);
      }, 5000);
      return () => clearInterval(interval);
    }, [index]);
    return (
      <>
         <div style={{
          "textAlign": "center",
          "justifyContent": "space-evenly",
          "alignItems": "center",
          "maxWidth":"100vw",
          "marginTop":"5%",
          display:"flex",
          flexDirection:"row",
          columnGap:"60px",
          paddingTop:"5%"
         }}>
          <div style={{maxWidth:"90%"}}>
          <h1 style={{lineHeight: "40px",
    paddingLeft: "20px",letterSpacing:"1px",color:"#007FFF",fontSize:"50px"}}>Features</h1>
         <h2 id="headline" style={{lineHeight: "40px",
    paddingLeft: "20px",maxWidth:"70vh",wordSpacing:"2px",FontSize:"40px",fontWeight: "normal",color:`${props.mode}==light?black:white`,fontFamily:"poppins"}}>{heading}</h2>
          </div>
         <img src={img} style={{display:"fixed",marginRight:"1vw",width:"40vw",height:"auto",paddingTop:"-40vh",borderRadius:"15px"}}></img>
         </div>
      </>
    )
  }
  
  export default Home;
  