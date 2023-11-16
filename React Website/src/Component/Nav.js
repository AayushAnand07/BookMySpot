import React from 'react'
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import Menu from '@mui/material/Menu';
import MenuIcon from '@mui/icons-material/Menu';
import Container from '@mui/material/Container';
import MenuItem from '@mui/material/MenuItem';
import useMediaQuery from '@mui/material/useMediaQuery';
import { makeStyles } from '@mui/styles';
import { Routes, Route,Link } from "react-router-dom"
import { withRouter } from 'react-router';
import poppins from "@fontsource/poppins"
import "./N.css";
import Taable from "./Table";
import RevenueTable from './RevenueTable';
import CustomParking from '../Component/CustomParking';
import Person2OutlinedIcon from '@mui/icons-material/Person2Outlined';
import Home from './Home';
import ParkingOverview from './ParkingOverview';
import CustomRevenue from './CustomRevenue';
import CheckedOut from './CheckedOut';
const pages = ['DashBoard', 'Revenue', 'Parking Overview'];

let useStyle = makeStyles({

  Drop: {

  },

  color: {
    display: 'block',
    '&:hover': {
      color: "#E76E26",
      backgroundColor: "#BC0063",
      fontFamily: `${poppins}`
    },
    '@media(max-Width: 720px)': {
      MaxWidth: "5vh",
    }
  },

  End: {
    justifyContent: "end"
  },
  Size: {
    webkitTransform: "scaleX(0.5)",
    transform: "scaleX(0.5)",
  },
  Font: {
    fontFamily: "poppins",
    fontSize: "larger",
    textTransform: "capitalize",
    fontWeight:"350",
  }
  ,
});

const Nav = () => {
  let css = useStyle();
  const [anchorElNav, setAnchorElNav] = React.useState(null);
  const [anchorElUser, setAnchorElUser] = React.useState(null);
  const matches = useMediaQuery('(min-width:600px)');
  const handleOpenNavMenu = (event) => {
    setAnchorElNav(event.currentTarget);
  };
  const handleOpenUserMenu = (event) => {
    setAnchorElUser(event.currentTarget);
  };

  const handleCloseNavMenu = () => {
    setAnchorElNav(null);
  };

  const handleCloseUserMenu = () => {
    setAnchorElUser(null);
  };
  const HandleOnStyle = {
    '@media(max-Width: 850px)': {
      display: 'flex',
      justifyContent: "end"
    },
    '@media(min-Width: 850px)': {
      display: 'none',
    }
  }
  const HandleonLink=()=>{
    window.location.reload(false);
}
  return (
    <div style={{width:"100vw",height:"100vh"}}>
    <div>
      <AppBar position="static" style={{ backgroundColor: "#BC0063",position: "sticky" }}>
        <Container maxWidth="xl">
          <Toolbar disableGutters>  
            <Typography id="Title">BookMySpot</Typography>
            <Box sx={{ flexGrow: 1, display: { xs: 'flex', md: 'none' }, justifyContent: "end" }} className={`${css.End}`} >
              <IconButton
                style={HandleOnStyle}
                size="large"
                aria-label="account of current user"
                aria-controls="menu-appbar"
                aria-haspopup="true"
                onClick={handleOpenNavMenu}
                color="inherit"
              >
                <MenuIcon />
              </IconButton>
              <Menu

                id="menu-appbar"
                anchorEl={anchorElNav}
                anchorOrigin={{
                  vertical: 'bottom',
                  horizontal: 'left',

                }}
                keepMounted
                transformOrigin={{
                  vertical: 'top',
                  horizontal: 'left',

                }}
                open={Boolean(anchorElNav)}
                onClose={handleCloseNavMenu}
                sx={{
                  display: { xs: 'block', md: 'none' }
                }}

              >
                {pages.map((page) => (
                  <MenuItem key={page} onClick={handleCloseNavMenu} style={{width:"500px",Height:"900px",backgroundColor:"1C1C1C"}}  >
                    <Typography textAlign="center" exact activeClassName="active_link" to="/product">{page}</Typography>
                  </MenuItem>
                ))}
              </Menu>

            </Box>


            <Box sx={{ flexGrow: 1, display: { xs: 'none', md: 'flex' }, justifyContent: "end", columnGap: "61px" }}>
 
            <Link  class="dropbtn" to="./"><h2 className='NavFont'>DashBoard</h2></Link>             
            <div class="dropdown show">
  <Link class="dropbtn" to="/checkedin" style={{fontSize:"21px",paddingTop:"12px",display:"flex",fontFamily:"poppins"}} role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
  Revenue</Link>

  <div class="dropdown-menu NavFont" aria-labelledby="dropdownMenuLink" style={{borderRadius:"10px"}}>
    <Link class="dropdown-item" to="/checkedin">Checked-In</Link>
    <Link class="dropdown-item" to="/checkedout">Checked-Out</Link>
  </div>
</div>
            <Link class="dropbtn" to="./parking"><h2 className='NavFont'>Parking Overview</h2></Link>
            
            <div class="dropdown">
            <Link style={{display:"flex",flexDirection:"row",paddingTop:"10px"}} class="btn btn-default" data-hover="dropdown" type="button" data-toggle="dropdown" >
                <Person2OutlinedIcon fontSize="large" style={{color:"white",paddingLeft:"-10px"}}/>
                <h2 id="blue" style={{color:"white",paddingTop:"6px"}}>Akash</h2>
            </Link>
  <ul class="dropdown-menu" style={{borderRadius:"10px",maxWidth:"20%"}}>
    <li><Link onClick={HandleonLink} style={{textDecoration:"none !important",paddingLeft:"50px",fontSize:"20px",color:"#BC0063"}}>Logout</Link></li>
    </ul>
    </div>
            </Box>


          </Toolbar>
        </Container>
      </AppBar>
      
    </div>
    <Routes>
        <Route exact path="/" element={<CustomRevenue/>}/>
        <Route exact path="/checkedin" element={<Taable/>}/>
        <Route exact path="/parking" element={<CustomParking/>}/>
        <Route exact path="/checkedout" element={<CheckedOut></CheckedOut>}/>
        </Routes>
    </div>
  )
}

export default (Nav);
