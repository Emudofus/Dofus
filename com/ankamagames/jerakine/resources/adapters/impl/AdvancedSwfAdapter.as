package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.adapters.AbstractLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.types.ASwf;
   import flash.display.LoaderInfo;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.utils.system.AirScanner;


   public class AdvancedSwfAdapter extends AbstractLoaderAdapter implements IAdapter
   {
         

      public function AdvancedSwfAdapter() {
         super();
      }



      private var _aswf:ASwf;

      override protected function getResource(ldr:LoaderInfo) : * {
         return this._aswf;
      }

      override public function getResourceType() : uint {
         return ResourceType.RESOURCE_ASWF;
      }

      override protected function init(ldr:LoaderInfo) : void {
         if(AirScanner.hasAir())
         {
            this._aswf=new ASwf(ldr.loader.content,ldr.applicationDomain,ldr.width,ldr.height);
         }
         else
         {
            this._aswf=new ASwf(ldr.loader.content,ldr.applicationDomain,800,600);
         }
         super.init(ldr);
      }
   }

}