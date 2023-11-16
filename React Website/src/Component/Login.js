import React,{Component} from "react";


import styled from "styled-components";
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import MailOutlineIcon from '@mui/icons-material/MailOutline';
import img from "./Img/back.png"
import { useState } from "react";

export const Section=styled.section`
     display:flex;
     padding-left:10%;
     align-items:center;
     min-height:100vh;
     width:100%;
     background:url(${img}) no-repeat; 
     background-position:center;
     background-size:cover;
     padding-left:-20%;
`
export const OuterDiv=styled.div`
    width:400px;
    height:341px;
    position:relative;
    top:60px;
    display:flex;
    justify-content:center;
    align-items:center;
    background-color:white;
    border-radius:20px;
`
export const InnerDiv=styled.div`
`
export const Form=styled.form`
`
export const Logiin=styled.h2`
    font-size:2em;
    color:white;
    text-align:center;
`
export const InputBox=styled.div`
  position:relative;
  margin:30px 0;
  width:310px;
  padding-top:-20%;
`
export const Input=styled.input`
position: relative;
width: 85%;
height: 50px;
background-color: #FOEDE5 !important;
mix-blend-mode: normal;
border-radius: 18px;
border:2px solid #FOEDE5;
`
export const Label=styled.label`
position: absolute;


font-family: 'Inter';
font-style: normal;
font-weight: 900;
font-size: 25px;
line-height: 36px;

color: #BC0063;
padding-top:-10%;
top:-70%;
left:10%;
`
export const Button=styled.button`
     width:40%;
     height:8vh;
     border-radius:10px;
     background:#fff;
     cursor:pointer;
     font-size:20px;
     outline:none;
     font-weight:600;
     color:#BC0063;
     border: 2px solid #BC0063;
     box-shadow: -4px 4px 0px #BC0063;
`
export default class Login extends Component {
  constructor(props) {
    super(props);
    this.state = {
        email: "",
        password: "",
    }
  }
   HandleOnChange = (e) => {
      this.setState({
          [e.target.name]: e.target.value.toString()
      });
      console.log(this.state);
    }
    HandleonClick = async(e) => {
      e.preventDefault();
      if(this.state.password==="akki" && this.state.email==="akash.20bcr7060@vitap.ac.in"){
              this.props.setUnlock(current=>true);
      }
      else{
        alert("Invalid Credentials!!");
        console.log(this.state.password)
      }
       
    }
    render() {
      return( 
        <>
      <Section style={{display:"flex",flexDirection:"column"}}>
        <div style={{marginLeft:"-70%"}}>
      <div>
      <h1 style={{position:"relative",color:"white",fontSize:"400%",paddingTop:"15%",fontFamily:"poppins"}}>BookMySpot</h1>
      </div>
     <OuterDiv style={{display:"flex",flexDirection:"column"}}> 
     
     <InnerDiv>
        <Form action="" autocomplete="off">
            <InputBox>
            <Label style={{paddingLeft:"-30%",fontFamily:"poppins"}}>Username</Label>

            <Input type="email" name="email" required onChange={this.HandleOnChange} autocomplete="off"></Input>
            
            </InputBox> <br></br>
            <InputBox>
            <Label style={{fontFamily:"poppins"}}>Password</Label>
            <Input type="password" name="password" required onChange={this.HandleOnChange}></Input>
            
            </InputBox>
            <Button onClick={this.HandleonClick} style={{fontFamily:"poppins"}}>Log in</Button>
        </Form>
     </InnerDiv>
     </OuterDiv>
     </div>
      </Section>
      </>
    );
}
  }