import React,{useState} from 'react'
import img from "./Img/Rectangle 13.png"
import "./CustomParking.css";

const CustomParking = () => {
  const [list,setList]=React.useState([
    {
        SpotNumber:"A1",
        status:"Free",
        Name:"",
        Email:"",
        Phone:"",
        plate:"",
        },
    {
      SpotNumber:"A2",
      status:"Free",
      Name:"",
      Email:"",
      Phone:"",
      plate:"",
        },
    {
      SpotNumber:"A3",
      status:"Occupied",
      Name:"Akash",
      Email:"3/4/6",
      Phone:783872637,
      plate:"ada998u9",
     },
    {
      SpotNumber:"A4",
      status:"Occupied",
      Name:"Aayush",
      Email:"pcdsjcsjkcjkn",
      Phone:783872637,
      plate:"ada998dwu9",
         },
    {
      SpotNumber:"A5",
      status:"Occupied",
      Name:"Harsh",
      Email:"swbjkjkbj",
      Phone:783872637,
      plate:"ada998u9",
        },
        {
        SpotNumber:"A6",
        status:"Free",
        Name:"-",
        Email:"-",
        Phone:"-",
        plate:"-",
        }
   ])
   const [spot, setSpot] = useState('');
   const [status, setStatus] = useState('');
   const [name, setName] = useState('');
   const [mail, setMail] = useState('');
   const [phone, setPhone] = useState('');
   const [plate, setPlate] = useState('');
    const listButton=["A1","A2","A3","A4","A5","A6"];
    const disabledd=[false,false,true,true,true,false];
   function HandleOnClick(x,index){
      console.log(list[index]);
      setSpot(list[index].SpotNumber);
      setStatus(list[index].status);
      setName(list[index].Name);
      setMail(list[index].Email);
      setPhone(list[index].Phone);
      setPlate(list[index].plate);

    }
  return (
    <div style={{display:"flex",flexDirection:"row",height:"79vh"}}>
      <div style={{width:"30%",backgroundColor:"white",MaxHeight:"79vh"}}>
        <form>
        <label for="validationTooltip01" id='Label' class="Spot">Spot Number</label>
      <input type="text" class="form-control" id="validationTooltip01" value={spot} required/>
      <label for="validationTooltip01" id='Label'>Status</label>
      <input type="text" class="form-control" id="validationTooltip01" value={status} required/>
      <label for="validationTooltip01" id='Label'>Name</label>
      <input type="text" class="form-control" id="validationTooltip01" value={name} required/>
      <label for="validationTooltip01" id='Label' class="email">E-mail ID</label>
      <input type="text" class="form-control" id="validationTooltip01" value={mail} required/>
      <label for="validationTooltip01" id='Label' class="phone">Phone Number</label>
      <input type="text" class="form-control" id="validationTooltip01" value={phone} required/>
      <label for="validationTooltip01" id='Label' class="plate">Number Plate</label>
      <input type="text" class="form-control" id="validationTooltip01" value={plate} required/>

      
        </form>
      </div>
      <div style={{border:"1px solid #BC0063",height:"89.5vh"}}></div>
        <div style={{width:"55%",display:"flex",flexDirection:"row",flexWrap:"wrap",justifyContent:"space-between",alignItems:"flex-start",MaxWidth:"5vw",rowGap:"48px",columnGap:"13%",paddingTop:"0%",marginLeft:"6%"}}>
      {listButton.map((x,index)=>{
        return(
            <button key={x} style={{border:"black"}} onClick={()=>HandleOnClick(x,index)} class="btn">
                <div style={{border:"2px solid black",borderRadius:"10px",height:"210px",width:"110px",background:`${disabledd[index]}?${console.log("hello")}:${console.log("mc")} !important`}} class="mainDiv">
                  <div>
                   {
                    disabledd[index]?<img src={img} alt="car" height="200px"></img>:""
                   }
                  </div>
                  
                </div>
                {x}
            </button>
        )
    })}
    </div>
    </div>
  )
}

export default CustomParking

