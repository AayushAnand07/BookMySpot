import React, { useState } from 'react'
import PropTypes from 'prop-types';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import CssBaseline from '@mui/material/CssBaseline';
import Divider from '@mui/material/Divider';
import Drawer from '@mui/material/Drawer';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import DashboardIcon from '@mui/icons-material/Dashboard';
import CurrencyRupeeIcon from '@mui/icons-material/CurrencyRupee';
import LocalParkingIcon from '@mui/icons-material/LocalParking';
import LaptopChromebookIcon from '@mui/icons-material/LaptopChromebook';
import AssessmentIcon from '@mui/icons-material/Assessment';
import TextField from '@mui/material/TextField';
import SearchIcon from '@mui/icons-material/Search';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import { styled } from '@mui/material/styles';
import CardComp from './CardComp';
import NotificationsIcon from '@mui/icons-material/Notifications';
import AccountCircleIcon from '@mui/icons-material/AccountCircle';
import Booking from './Booking';
import Vacant from './Vacant';
import { makeStyles } from '@mui/styles';
import Taable from "./Table";
import Toggle from 'react-bootstrap-toggle';
import { pink } from '@mui/material/colors';
import Switch from '@mui/material/Switch';
import { alpha } from '@mui/material/styles';
import { Routes, Route,Link } from "react-router-dom"
import FormControlLabel from '@mui/material/FormControlLabel';
import RevenueTable from './RevenueTable';
import Home from './Home';
import ParkingOverview from './ParkingOverview';

const Item = styled(Paper)(({ theme }) => ({
  backgroundColor: theme.palette.mode === 'dark' ? '#1A2027' : '#fff',
  ...theme.typography.body2,
  padding: theme.spacing(1),
  textAlign: 'center',
  color: theme.palette.text.secondary,
}));
let useStyle = makeStyles({
  Drop:{
    BackgroundColor:"green",
  },
});


const MaterialUISwitch = styled(Switch)(({ theme }) => ({
  width: 62,
  height: 34,
  padding: 7,
  '& .MuiSwitch-switchBase': {
    margin: 1,
    padding: 0,
    transform: 'translateX(6px)',
    '&.Mui-checked': {
      color: '#fff',
      transform: 'translateX(22px)',
      '& .MuiSwitch-thumb:before': {
        backgroundImage: `url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" height="20" width="20" viewBox="0 0 20 20"><path fill="${encodeURIComponent(
          '#fff',
        )}" d="M4.2 2.5l-.7 1.8-1.8.7 1.8.7.7 1.8.6-1.8L6.7 5l-1.9-.7-.6-1.8zm15 8.3a6.7 6.7 0 11-6.6-6.6 5.8 5.8 0 006.6 6.6z"/></svg>')`,
      },
      '& + .MuiSwitch-track': {
        opacity: 1,
        backgroundColor: theme.palette.mode === 'dark' ? '#8796A5' : '#aab4be',
      },
    },
  },
  '& .MuiSwitch-thumb': {
    backgroundColor: theme.palette.mode === 'dark' ? '#003892' : '#001e3c',
    width: 32,
    height: 32,
    '&:before': {
      content: "''",
      position: 'absolute',
      width: '100%',
      height: '100%',
      left: 0,
      top: 0,
      backgroundRepeat: 'no-repeat',
      backgroundPosition: 'center',
      backgroundImage: `url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" height="20" width="20" viewBox="0 0 20 20"><path fill="${encodeURIComponent(
        '#fff',
        )}" d="M9.305 1.667V3.75h1.389V1.667h-1.39zm-4.707 1.95l-.982.982L5.09 6.072l.982-.982-1.473-1.473zm10.802 0L13.927 5.09l.982.982 1.473-1.473-.982-.982zM10 5.139a4.872 4.872 0 00-4.862 4.86A4.872 4.872 0 0010 14.862 4.872 4.872 0 0014.86 10 4.872 4.872 0 0010 5.139zm0 1.389A3.462 3.462 0 0113.471 10a3.462 3.462 0 01-3.473 3.472A3.462 3.462 0 016.527 10 3.462 3.462 0 0110 6.528zM1.665 9.305v1.39h2.083v-1.39H1.666zm14.583 0v1.39h2.084v-1.39h-2.084zM5.09 13.928L3.616 15.4l.982.982 1.473-1.473-.982-.982zm9.82 0l-.982.982 1.473 1.473.982-.982-1.473-1.473zM9.305 16.25v2.083h1.389V16.25h-1.39z"/></svg>')`,
      },
    },
    '& .MuiSwitch-track': {
      opacity: 1,
      backgroundColor: theme.palette.mode === 'dark' ? '#8796A5' : '#aab4be',
      borderRadius: 20 / 2,
    },
  }));
  
  
  const drawerWidth = 240;
const SideNav = (props) => {
  const [mode,setMode]=React.useState("light");
  const css=useStyle();
  const { window } = props;
  const [mobileOpen, setMobileOpen] = React.useState(false);
  const icons=[<DashboardIcon/>,<CurrencyRupeeIcon/>,<LocalParkingIcon/>,<LaptopChromebookIcon/>,<AssessmentIcon/>]
  const link=["/Dashboard","/revenue","parking","/booking","report"]
  const disable=[false,false,true,true,true];
  
  
   const HandleonClick=()=>{
       if(mode==="light"){
        setMode("dark");
        document.body.style.backgroundColor = "#142044";
      }
      else{
        setMode("light");
        document.body.style.backgroundColor = "white";
       }
       console.log(mode);
   }

   const HandleonLink=()=>{
       window.location.reload(false);
   }
    
   const PinkSwitch = styled(Switch)(({ theme }) => ({
    '& .MuiSwitch-switchBase.Mui-checked': {
      color: pink[600],
      '&:hover': {
        backgroundColor: alpha(pink[600], theme.palette.action.hoverOpacity),
      },
    },
    '& .MuiSwitch-switchBase.Mui-checked + .MuiSwitch-track': {
      backgroundColor: pink[600],
    },
  }));

  const handleDrawerToggle = () => {
    setMobileOpen(!mobileOpen);
  };

  const drawer = (
    
    <div>
      <Toolbar style={{backgroundColor:"#BC0063"}}/>
      <Divider />
      <List style={{Maxheight:"90%"}}>
        {['Dashboard', 'Revenue Data', 'Parking Overview', 'Booking',"Report"].map((text, index) => (
          <ListItem key={text} disablePadding style={{display:"flex",flexDirection:"row",width:"100%"}}>
            <Link className={`${css.Drop}`} to={link[index]} style={{textDecoration:"none",color:"black",width:"100%",display:"flex"}}>
              <ListItemIcon>
                {icons[index]}
              </ListItemIcon>
              <ListItemText primary={text} style={{backgroundColor:`${mode}==="light"?"white":"#142044"`}}/>
            </Link>
          </ListItem>
        ))}
      </List>
      <Divider />
      
    </div>
  );

  const container = window !== undefined ? () => window().document.body : undefined;
  return (
    <>
    
    <Box sx={{ display: 'flex'}}>
      <CssBaseline />
      <AppBar
      className='bg-${mode}'
        position="fixed"
        sx={{
          width: { sm: `calc(100% - ${drawerWidth}px)` },
          ml: { sm: `${drawerWidth}px` },
        }}
        style={{display:"flex",flexDirection:"row",justifyContent:"space-between",backgroundColor:"#BC0063",height:"64px"}}
      >
        
    <h1 style={{"marginLeft":"20px",fontSize:"45x",color:`${mode}==="light"?"black":"white"`,paddingTop:"8px"}}>BookMySpot</h1>
      </AppBar>
  
        <Box
        component="nav"
        sx={{ width: { sm: drawerWidth }, flexShrink: { sm: 0 } }}
        aria-label="mailbox folders"
      >
        {/* The implementation can be swapped with js to avoid SEO duplication of links. */}
        <Drawer
          container={container}
          variant="temporary"
          open={mobileOpen}
          onClose={handleDrawerToggle}
          ModalProps={{
            keepMounted: true, // Better open performance on mobile.
          }}
          sx={{
            display: { xs: 'block', sm: 'none' },
            '& .MuiDrawer-paper': { boxSizing: 'border-box', width: drawerWidth },
          }}
        >
          {drawer}
        </Drawer>
        <Drawer
          variant="permanent"
          sx={{
            display: { xs: 'none', sm: 'block' },
            '& .MuiDrawer-paper': { boxSizing: 'border-box', width: drawerWidth },
          }}
          open
        >
          {drawer}
          
        </Drawer>
      <Box
        component="main"
        sx={{ flexGrow: 1, p: 3, width: { sm: `calc(100% - ${drawerWidth}px)` } }}
        style={{backgroundColor:"#DBECF4"}}
        >

        <Toolbar />
          </Box>
      
    
      </Box>
     
        <Routes>
        <Route exact path="/" element={<Home mode={mode} setMode={setMode}/>}/>
        <Route exact path="/Dashboard" element={<Taable mode={mode} setMode={setMode}/>}/>
        <Route exact path="/revenue" element={<RevenueTable mode={mode} setMode={setMode}/>}/>
        <Route exact path="/parking" element={<ParkingOverview/>}></Route>
        </Routes>
        

    </Box>
    
    </>
  )
}

export default SideNav
