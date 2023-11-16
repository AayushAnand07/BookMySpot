import React, { useState ,useEffect} from 'react'
import {Table} from 'react-bootstrap'
import "./Table.css"
import {db} from '../firebase';
import { collection, doc,getDocs,where,query,getDoc,onSnapshot } from "firebase/firestore";
function Taable(props){
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

    const [list,setList]=useState([
    {
        NumberPlate:353453,
        Name:"Akash",
        MobileNumber:"9327443278",
        CheckinTime:"3/4/6",
        },
    {
        NumberPlate:2345345,
        Name:"Aayush",
        MobileNumber:"9242532577",
        CheckinTime:"2/3/3",
        },
    {
        NumberPlate:36432454,
        Name:"Kartik",
        MobileNumber:"925276787",
        CheckinTime:"8/4/3",
     },
    {
        NumberPlate:44235543,
        Name:"Harsh",
        MobileNumber:"936883562",
        CheckinTime:"1/3/3",
         },
    {
        NumberPlate:56534242,
        Name:"Jasjot",
        MobileNumber:"9123983098",
        CheckinTime:"9/6/4",
        },
   ])
  return (
<>
    <Table class="mt-4" striped bordered hover variant={`${props.mode}`} style={{width:"100vw"}}>
  <thead>
        <tr>
         <th>Sno.</th>
          <th>Name</th>
          <th>Number Plate</th>
          <th>Phone Number</th>
         
          <th>Check-in Time</th>
        </tr>
      </thead>
      <tbody>                                                                                 
      {TableData.map((data,i)=>{
        console.log(data)
         var enter = new Date(data.CheckIn.seconds* 1000 + data.CheckIn.nanoseconds/1000000).toLocaleString()
        // console.log(enter[0])
        console.log(data.CheckIn)
          return(
          <tr key={data.PlateNumber}>
          <td>{i+1}</td>
          <td>{data.Name}</td>
          <td>{data.PlateNumber}</td>
          <td>{data.MobileNumber}</td>
          <td>{enter}</td>
             
          </tr>
          )})
          }
    </tbody>
      </Table>
      </>
  )
}

export default Taable
