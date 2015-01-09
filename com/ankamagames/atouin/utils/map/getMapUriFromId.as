package com.ankamagames.atouin.utils.map
{
    import com.ankamagames.atouin.Atouin;

    public function getMapUriFromId(mapId:int):String
    {
        return (((((Atouin.getInstance().options.mapsPath + (mapId % 10)) + "/") + mapId) + ".dlm"));
    }

}//package com.ankamagames.atouin.utils.map

