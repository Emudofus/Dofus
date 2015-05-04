package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.PortalInformation;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameRolePlayPortalInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public function GameRolePlayPortalInformations()
      {
         this.portal = new PortalInformation();
         super();
      }
      
      public static const protocolId:uint = 467;
      
      public var portal:PortalInformation;
      
      override public function getTypeId() : uint
      {
         return 467;
      }
      
      public function initGameRolePlayPortalInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:PortalInformation = null) : GameRolePlayPortalInformations
      {
         super.initGameRolePlayActorInformations(param1,param2,param3);
         this.portal = param4;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.portal = new PortalInformation();
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayPortalInformations(param1);
      }
      
      public function serializeAs_GameRolePlayPortalInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayActorInformations(param1);
         param1.writeShort(this.portal.getTypeId());
         this.portal.serialize(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayPortalInformations(param1);
      }
      
      public function deserializeAs_GameRolePlayPortalInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         this.portal = ProtocolTypeManager.getInstance(PortalInformation,_loc2_);
         this.portal.deserialize(param1);
      }
   }
}
