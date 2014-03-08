package com.ankamagames.dofus.network.types.game.look
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class EntityLook extends Object implements INetworkType
   {
      
      public function EntityLook() {
         this.skins = new Vector.<uint>();
         this.indexedColors = new Vector.<int>();
         this.scales = new Vector.<int>();
         this.subentities = new Vector.<SubEntity>();
         super();
      }
      
      public static const protocolId:uint = 55;
      
      public var bonesId:uint = 0;
      
      public var skins:Vector.<uint>;
      
      public var indexedColors:Vector.<int>;
      
      public var scales:Vector.<int>;
      
      public var subentities:Vector.<SubEntity>;
      
      public function getTypeId() : uint {
         return 55;
      }
      
      public function initEntityLook(param1:uint=0, param2:Vector.<uint>=null, param3:Vector.<int>=null, param4:Vector.<int>=null, param5:Vector.<SubEntity>=null) : EntityLook {
         this.bonesId = param1;
         this.skins = param2;
         this.indexedColors = param3;
         this.scales = param4;
         this.subentities = param5;
         return this;
      }
      
      public function reset() : void {
         this.bonesId = 0;
         this.skins = new Vector.<uint>();
         this.indexedColors = new Vector.<int>();
         this.scales = new Vector.<int>();
         this.subentities = new Vector.<SubEntity>();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_EntityLook(param1);
      }
      
      public function serializeAs_EntityLook(param1:IDataOutput) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_EntityLook(param1);
      }
      
      public function deserializeAs_EntityLook(param1:IDataInput) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
