package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.scripts.api.FxApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   import com.ankamagames.jerakine.script.api.EffectsApi;
   import com.ankamagames.jerakine.script.api.LoggingApi;
   import com.ankamagames.jerakine.script.api.MathApi;
   import com.ankamagames.jerakine.script.api.RootApi;
   import com.ankamagames.jerakine.script.api.StringApi;
   import com.ankamagames.jerakine.script.api.TimeApi;
   import com.ankamagames.jerakine.script.api.VectorApi;
   import com.ankamagames.dofus.uiApi.ColorApi;
   
   public class ApiList extends Object
   {
      
      public function ApiList() {
         super();
      }
      
      protected static var include_FxApi:FxApi = null;
      
      protected static var include_SpellFxApi:SpellFxApi = null;
      
      protected static var include_SequenceApi:SequenceApi = null;
      
      protected static var include_EffectsApi:EffectsApi = null;
      
      protected static var include_LoggingApi:LoggingApi = null;
      
      protected static var include_MathApi:MathApi = null;
      
      protected static var include_RootApi:RootApi = null;
      
      protected static var include_StringApi:StringApi = null;
      
      protected static var include_TimeApi:TimeApi = null;
      
      protected static var include_VectorApi:VectorApi = null;
      
      protected static var include_ColorApi:ColorApi = null;
   }
}
