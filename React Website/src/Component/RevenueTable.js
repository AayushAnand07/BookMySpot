import React, { useState,useEffect} from 'react'
import {Table} from 'react-bootstrap'
import {db} from '../firebase';
import { collection, doc,getDocs,where,query,getDoc,onSnapshot } from "firebase/firestore";
const RevenueTable = (props) => {
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
  
      setTableData(updatedData);
    };
  
    useEffect(() => {
      fetchEntriesAndUsers();
    }, []);
    const handleOnSubmit=()=>{
      setCount(count+1);
      console.log(count());
    }

 
  return (
    <div>
    <Table class="mt-4" striped bordered hover variant={`${props.mode}`} style={{width:"82vw",marginTop:"9vh"}}>
  <thead>
        <tr>
          <th>Sno.</th>
          <th>Number Plate</th>
          <th>Name</th>
          <th>Mobile Number</th>
          <th>Checkin Time</th>
        </tr>
      </thead>
      <tbody>                                                                                 
      {TableData.map((data,i)=>{
        console.log(data)
         var enter = new Date(data.CheckIn.seconds* 1000 + data.CheckIn.nanoseconds/1000000).toLocaleString()
        // console.log(enter[0])
        console.log(data.CheckIn)
          return(
          <tr key={i}>
          <td>{i+1}</td>
          <td>{data.PlateNumber}</td>
          <td>{data.Name}</td>
          <td>{data.MobileNumber}</td>
          <td>{enter}</td>
              <td>{data.Status}</td>
          </tr>
          )})
          }
    </tbody>
      </Table>
    </div>
  )
}

export default RevenueTable
