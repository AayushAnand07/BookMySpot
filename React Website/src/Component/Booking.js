import React from 'react'
import { useTheme } from '@mui/material/styles';
import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardMedia from '@mui/material/CardMedia';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import SkipPreviousIcon from '@mui/icons-material/SkipPrevious';
import PlayArrowIcon from '@mui/icons-material/PlayArrow';
import SkipNextIcon from '@mui/icons-material/SkipNext';
import DirectionsCarIcon from '@mui/icons-material/DirectionsCar';
import TwoWheelerIcon from '@mui/icons-material/TwoWheeler';
const Booking = () => {
    const theme = useTheme();
    const [FourCount,FoursetCount]=React.useState(0);
    const [TwoCount,TwosetCount]=React.useState(0);
  return (
    <Card style={{width:"350px",height:"200px",marginLeft:"10%"}} >
        <div style={{height:"20px"}}>
        <h2 style={{fontSize:"larger",height:"20px"}}>Booking</h2>
        </div>
        <div style={{display:"flex"}}>
    <Box sx={{ display: 'flex', flexDirection: 'column' }}>
      <CardContent sx={{ flex: '1 0 auto' }}>
        <Typography component="div" variant="h5" style={{fontSize:"large",marginLeft:"50px"}}>
          Offline
        </Typography>
        
      </CardContent>
      <Box sx={{ display: 'flex', alignItems: 'center', pl: 1, pb: 1 }} style={{justifyContent:"center",marginLeft:"50px"}}>
      {FourCount}
      </Box>
      <Typography component="div" variant="h5" style={{fontSize:"large",marginLeft:"50px"}}>
          Booked today
        </Typography>
    </Box>
    <hr></hr>
    <Box sx={{ display: 'flex', flexDirection: 'column' }}>
    <CardContent sx={{ flex: '1 0 auto' }}>
        <Typography component="div" variant="h5" style={{fontSize:"large",marginRight:"6px"}}>
          Online
        </Typography>
        <Box sx={{ display: 'flex', alignItems: 'center', pl: 1, pb: 1 }} style={{justifyContent:"center"}}>
        {TwoCount}
        </Box>
        <Typography component="div" variant="h5" style={{fontSize:"large",marginLeft:"20px"}}>
          Booked today
        </Typography>
      </CardContent>
    </Box>
    </div>
  </Card>
  )
}

export default Booking
