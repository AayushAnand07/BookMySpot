import React,{useState,useEffect} from 'react'
import {Table} from 'react-bootstrap'
import "./Table.css"
import {db} from '../firebase';
import { collection, doc,getDocs,where,query,getDoc,onSnapshot } from "firebase/firestore";

const CheckedOut = (props) => {
    const [count,setCount]=useState(0);
    const [TableData, setTableData] = useState([]);    
    
 
    const fetchEntriesAndUsers = async () => {
     const entrySnapshot = collection(db, "Entry");
     const userSnapshot = collection(db, "Users");
 
     const [entryQuerySnapshot, userQuerySnapshot] = await Promise.all([
       getDocs(entrySnapshot),
       getDocs(userSnapshot),
     ]);
 
     const entryData = entryQuerySnapshot.docs.map((doc) => ({...doc.data(), id: doc.id}));
     const userData = userQuerySnapshot.docs.map((doc) => ({...doc.data(), id: doc.id}));
 
     const updatedData = entryData.map((entry) => {
       const user = userData.find((user) => user.NumberPlate === entry.PlateNumber);
       return {
         ...entry,
         Name: user ? user.Name : "",
         MobileNumber: user ? user.MobileNumber:"",
          
       };
     });
    //  updatedData.sort((a, b) => b.CheckOutTime.seconds - a.CheckOutTime.seconds);
     setTableData(updatedData);
   };
 
   useEffect(() => {
     fetchEntriesAndUsers();
   }, []);
  
  return (
      <>
    <Table class="mt-4" striped bordered hover variant={`${props.mode}`} style={{width:"100vw"}}>
  <thead>
        <tr>
        <th>SNo.</th>
          <th>Number Plate</th>
          <th>Name</th>
          <th>Mobile Number</th>
          <th>CheckIn Time</th>
          <th>CheckOut Time</th>
          <th>Amount</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>                                                                                 
      {TableData.filter(data => data.Amount!== undefined).map((data,i)=>{
        console.log(data)
         var enter = new Date(data.CheckIn.seconds* 1000 + data.CheckIn.nanoseconds/1000000).toLocaleString()
         var exit = new Date(data.CheckOutTime.seconds* 1000 + data.CheckOutTime.nanoseconds/1000000).toLocaleString()
       
        console.log(data.CheckIn)
          return(
          <tr key={i}>
          <td>{i+1}</td>
          <td>{data.PlateNumber}</td>
          <td>{data.Name}</td>
          <td>{data.MobileNumber}</td>
          <td>{enter}</td>
              <td>{exit}</td>
              <td>{"₹"+data.Amount}</td>
              <td style={data.Payment==="PENDING"?{color:"red"}:{color:"green"}}>{data.Payment}</td>
          </tr>
          )})
          
          }
    </tbody>
      </Table>
      </>
  )
}


export default CheckedOut;
