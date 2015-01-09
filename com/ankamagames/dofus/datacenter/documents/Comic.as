package com.ankamagames.dofus.datacenter.documents
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;

    public class Comic implements IDataCenter 
    {

        private static const MODULE:String = "Comics";

        public var id:int;
        public var remoteId:String;
        public var readerUrl:String;


        public static function getComicById(id:int):Comic
        {
            return ((GameData.getObject(MODULE, id) as Comic));
        }

        public static function getComics():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.documents

