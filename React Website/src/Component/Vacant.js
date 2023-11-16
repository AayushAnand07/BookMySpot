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
const Vacant = () => {
    const theme = useTheme();
    const [FourCount,FoursetCount]=React.useState(0);
    const [TwoCount,TwosetCount]=React.useState(0);
  return (
    <Card style={{width:"250px",height:"200px",marginLeft:"10%",marginTop:"-20px"}}>
    <Box sx={{ display: 'flex'}}>
      <CardContent sx={{ flex: '1 0 auto' }}>
        <div style={{columnGap:"23px",display:"flex",paddingLeft:"20px"}}>
      <DirectionsCarIcon style={{color:"orange"}}/>
      <TwoWheelerIcon style={{color:"orange"}}/>
      </div>
    <Typography component="div" variant="h5" style={{fontSize:"large",marginRight:"6px"}}>
          Vacant Slot
        </Typography>
        <Box sx={{ display: 'flex', alignItems: 'center', pl: 1, pb: 1 }} style={{justifyContent:"center"}}>
        {TwoCount}
        </Box>
        
      </CardContent>
    </Box>
    
   
  </Card>
  )
}

export default Vacant
