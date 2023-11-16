import logo from './logo.svg';
import React,{useEffect} from 'react';
import './App.css';
import SideNav from "./Component/SideNav.js"
import Login from './Component/Login';
import { Routes } from 'react-router-dom';
import { Route,Link } from "react-router-dom"
import ParkingOverview from './Component/ParkingOverview';
import CustomParking from './Component/CustomParking';
import Nav from './Component/Nav';
import Taable from "../src/Component/Table";
import RevenueTable from '../src/Component/RevenueTable';
import Person2OutlinedIcon from '@mui/icons-material/Person2Outlined';
import Home from '../src/Component/Home';
import CustomRevenue from './Component/CustomRevenue';


function App() {
  useEffect((user) => {
    console.log(user)
  },
  (error) => {
    console.log(error);
  });

  const[unlock,setUnlock]=React.useState(false);
    let button;
    if (unlock) {
      button = <Nav/>;
    } else {
      button = <Login unlock={unlock} setUnlock={setUnlock} />;
    }
  return (
    <div className="App">
    {button}
    </div>
  );
}

export default App;
