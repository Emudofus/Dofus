package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.prism.PrismInformation;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameRolePlayPrismInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public function GameRolePlayPrismInformations() {
         this.prism = new PrismInformation();
         super();
      }
      
      public static const protocolId:uint = 161;
      
      public var prism:PrismInformation;
      
      override public function getTypeId() : uint {
         return 161;
      }
      
      public function initGameRolePlayPrismInformations(param1:int=0, param2:EntityLook=null, param3:EntityDispositionInformations=null, param4:PrismInformation=null) : GameRolePlayPrismInformations {
         super.initGameRolePlayActorInformations(param1,param2,param3);
         this.prism = param4;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.prism = new PrismInformation();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameRolePlayPrismInformations(param1);
      }
      
      public function serializeAs_GameRolePlayPrismInformations(param1:IDataOutput) : void {
         super.serializeAs_GameRolePlayActorInformations(param1);
         param1.writeShort(this.prism.getTypeId());
         this.prism.serialize(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayPrismInformations(param1);
      }
      
      public function deserializeAs_GameRolePlayPrismInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         this.prism = ProtocolTypeManager.getInstance(PrismInformation,_loc2_);
         this.prism.deserialize(param1);
      }
   }
}
