package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameContextActorInformations extends Object implements INetworkType
   {
      
      public function GameContextActorInformations() {
         this.look = new EntityLook();
         this.disposition = new EntityDispositionInformations();
         super();
      }
      
      public static const protocolId:uint = 150;
      
      public var contextualId:int = 0;
      
      public var look:EntityLook;
      
      public var disposition:EntityDispositionInformations;
      
      public function getTypeId() : uint {
         return 150;
      }
      
      public function initGameContextActorInformations(param1:int=0, param2:EntityLook=null, param3:EntityDispositionInformations=null) : GameContextActorInformations {
         this.contextualId = param1;
         this.look = param2;
         this.disposition = param3;
         return this;
      }
      
      public function reset() : void {
         this.contextualId = 0;
         this.look = new EntityLook();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameContextActorInformations(param1);
      }
      
      public function serializeAs_GameContextActorInformations(param1:IDataOutput) : void {
         param1.writeInt(this.contextualId);
         this.look.serializeAs_EntityLook(param1);
         param1.writeShort(this.disposition.getTypeId());
         this.disposition.serialize(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameContextActorInformations(param1);
      }
      
      public function deserializeAs_GameContextActorInformations(param1:IDataInput) : void {
         this.contextualId = param1.readInt();
         this.look = new EntityLook();
         this.look.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         this.disposition = ProtocolTypeManager.getInstance(EntityDispositionInformations,_loc2_);
         this.disposition.deserialize(param1);
      }
   }
}
