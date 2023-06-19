
import * as React from "react";

import ToggleButtonGroup from "@mui/material/ToggleButtonGroup";
import ToggleButton from "@mui/material/ToggleButton";

import {useEffect, useState} from "react";
import Box from "@mui/material/Box";

export function getGifts() {
    return fetch("http://127.0.0.1:5000/gifts")
        .then(data => data.json());
}

export default function GiftList() {
    const [gifts, setGifts] = useState([]);
    const [selectedGifts, setSelectedGifts] = useState(() => []);

    useEffect(() => {
        let mounted = true;
        getGifts()
            .then(gifts => {
                if(mounted) {
                    console.log(gifts);
                    setGifts(gifts);
                }
            })
        return () => mounted = false;
    }, [])

    const handleGiftSelected = (event, selectedGifts) => {
        console.log('handled', event, selectedGifts);
        setSelectedGifts(selectedGifts);
    };

    return (
        <div>
                <ToggleButtonGroup
                    value={selectedGifts}
                    onChange={handleGiftSelected}
                    aria-label="text formatting"
                    style={{
                        display:"flex",
                        flexWrap:"wrap",
                        maxWidth: "700px"
                    }}
                >
                    {gifts.map(item => <ToggleButton
                                        style={{
                                            color: "#FFF",
                                            textAlign: "center",
                                            textTransform: "capitalize",
                                            flex: "1 0 100px",
                                            margin: "5px",
                                            padding: "0",
                                            height: "150px",
                                            alignItems: "center",
                                            alignContent: "space-between",
                                            justifyContent: "space-between",
                                            display: "flex",
                                            flexDirection: "column",
                                            // backgroundColor: "#FFF",
                                            // opacity: 0.3,

                                            // backgroundImage: `url("${item[1]}")`,
                                            // backgroundSize: "cover",
                                            // opacity: 0.5
                                            //temp styles
                                            // border: "3px solid red"
                                        }}
                                        key={item[0]}
                                        value={item[0]}
                                        aria-label={item[2]}>
                                            <h4 style={{opacity: 1, margin: 0, lineHeight: 1}}>{item[2]}</h4>
                                            <img src={item[1]} alt={item[2]} style={{width: "65%", opacity: 0.6, position: "absolute", top: 0, bottom: 0, margin: "auto 0"}}/>
                                            <p style={{fontSize: "0.8em", margin: 0, lineHeight: 0.8}}>{item[3]}</p>
                                       </ToggleButton>)}
                </ToggleButtonGroup>
            <h4>Selected: {selectedGifts.join(', ')}</h4>
        </div>
    );

}
