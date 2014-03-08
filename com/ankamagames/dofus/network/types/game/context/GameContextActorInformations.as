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
      
      public function initGameContextActorInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null) : GameContextActorInformations {
         this.contextualId = contextualId;
         this.look = look;
         this.disposition = disposition;
         return this;
      }
      
      public function reset() : void {
         this.contextualId = 0;
         this.look = new EntityLook();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameContextActorInformations(output);
      }
      
      public function serializeAs_GameContextActorInformations(output:IDataOutput) : void {
         output.writeInt(this.contextualId);
         this.look.serializeAs_EntityLook(output);
         output.writeShort(this.disposition.getTypeId());
         this.disposition.serialize(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameContextActorInformations(input);
      }
      
      public function deserializeAs_GameContextActorInformations(input:IDataInput) : void {
         this.contextualId = input.readInt();
         this.look = new EntityLook();
         this.look.deserialize(input);
         var _id3:uint = input.readUnsignedShort();
         this.disposition = ProtocolTypeManager.getInstance(EntityDispositionInformations,_id3);
         this.disposition.deserialize(input);
      }
   }
}
