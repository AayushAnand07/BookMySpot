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
const CardComp = () => {
    const theme = useTheme();
    const [FourCount,FoursetCount]=React.useState(0);
    const [TwoCount,TwosetCount]=React.useState(0);
  return (
    <Card sx={{ display: 'flex' }}>
    <Box sx={{ display: 'flex', flexDirection: 'column' }}>
      <CardContent sx={{ flex: '1 0 auto' }}>
      <DirectionsCarIcon style={{color:"green"}}/>
        <Typography component="div" variant="h5" style={{fontSize:"large",marginLeft:"20px"}}>
          Currently Checked In 
        </Typography>
        
      </CardContent>
      <Box sx={{ display: 'flex', alignItems: 'center', pl: 1, pb: 1 }} style={{justifyContent:"center"}}>
      {FourCount}
      </Box>
    </Box>
    <hr></hr>
    <Box sx={{ display: 'flex', flexDirection: 'column' }}>
    <CardContent sx={{ flex: '1 0 auto' }}>
      <TwoWheelerIcon style={{color:"orange"}}/>
        <Typography component="div" variant="h5" style={{fontSize:"large",marginRight:"6px"}}>
          Currently Checked In 
        </Typography>
        <Box sx={{ display: 'flex', alignItems: 'center', pl: 1, pb: 1 }} style={{justifyContent:"center"}}>
        {TwoCount}
        </Box>
      </CardContent>
    </Box>
  </Card>
  )
}

export default CardComp
