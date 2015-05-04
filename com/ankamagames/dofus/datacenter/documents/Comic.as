package com.ankamagames.dofus.datacenter.documents
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class Comic extends Object implements IDataCenter
   {
      
      public function Comic()
      {
         super();
      }
      
      private static const MODULE:String = "Comics";
      
      public static function getComicById(param1:int) : Comic
      {
         return GameData.getObject(MODULE,param1) as Comic;
      }
      
      public static function getComics() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var remoteId:String;
   }
}
