package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameRolePlayTaxCollectorInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public function GameRolePlayTaxCollectorInformations() {
         this.identification = new TaxCollectorStaticInformations();
         super();
      }
      
      public static const protocolId:uint = 148;
      
      public var identification:TaxCollectorStaticInformations;
      
      public var guildLevel:uint = 0;
      
      public var taxCollectorAttack:int = 0;
      
      override public function getTypeId() : uint {
         return 148;
      }
      
      public function initGameRolePlayTaxCollectorInformations(contextualId:int = 0, look:EntityLook = null, disposition:EntityDispositionInformations = null, identification:TaxCollectorStaticInformations = null, guildLevel:uint = 0, taxCollectorAttack:int = 0) : GameRolePlayTaxCollectorInformations {
         super.initGameRolePlayActorInformations(contextualId,look,disposition);
         this.identification = identification;
         this.guildLevel = guildLevel;
         this.taxCollectorAttack = taxCollectorAttack;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.identification = new TaxCollectorStaticInformations();
         this.taxCollectorAttack = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayTaxCollectorInformations(output);
      }
      
      public function serializeAs_GameRolePlayTaxCollectorInformations(output:IDataOutput) : void {
         super.serializeAs_GameRolePlayActorInformations(output);
         output.writeShort(this.identification.getTypeId());
         this.identification.serialize(output);
         if((this.guildLevel < 0) || (this.guildLevel > 255))
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element guildLevel.");
         }
         else
         {
            output.writeByte(this.guildLevel);
            output.writeInt(this.taxCollectorAttack);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayTaxCollectorInformations(input);
      }
      
      public function deserializeAs_GameRolePlayTaxCollectorInformations(input:IDataInput) : void {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.identification = ProtocolTypeManager.getInstance(TaxCollectorStaticInformations,_id1);
         this.identification.deserialize(input);
         this.guildLevel = input.readUnsignedByte();
         if((this.guildLevel < 0) || (this.guildLevel > 255))
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element of GameRolePlayTaxCollectorInformations.guildLevel.");
         }
         else
         {
            this.taxCollectorAttack = input.readInt();
            return;
         }
      }
   }
}
