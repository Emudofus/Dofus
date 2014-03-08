package com.ankamagames.atouin.utils.map
{
   public function getMapUriFromId(mapId:int) : String {
      return Atouin.getInstance().options.mapsPath + mapId % 10 + "/" + mapId + ".dlm";
   }
}
