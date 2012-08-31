// Action script...

// [Initial MovieClip Action of sprite 923]
#initclip 135
class dofus.aks.DataProcessor extends dofus.aks.Handler
{
    var api, aks;
    function DataProcessor(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function process(sData)
    {
        if (dofus.Constants.DEBUG)
        {
            ank.utils.Logger.log(">> " + sData);
        } // end if
        api.ui.unloadUIComponent("Waiting");
        api.ui.unloadUIComponent("WaitingMessage");
        var _loc5 = sData.charAt(0);
        var _loc3 = sData.charAt(1);
        var _loc4 = sData.charAt(2) == "E";
        this.postProcess(_loc5, _loc3, _loc4, sData);
    } // End of the function
    function postProcess(sType, sAction, bError, sData)
    {
        switch (sType)
        {
            case "H":
            {
                switch (sAction)
                {
                    case "C":
                    {
                        aks.onHelloConnectionServer(sData.substr(2));
                        break;
                    } 
                    case "G":
                    {
                        aks.onHelloGameServer(sData.substr(2));
                        break;
                    } 
                    default:
                    {
                        aks.disconnect(false, true);
                    } 
                } // End of switch
                break;
            } 
            case "p":
            {
                aks.onPong();
                break;
            } 
            case "M":
            {
                aks.onServerMessage(sData.substr(1));
                break;
            } 
            case "B":
            {
                switch (sAction)
                {
                    case "A":
                    {
                        switch (sData.charAt(2))
                        {
                            case "T":
                            {
                                aks.Basics.onAuthorizedCommand(true, sData.substr(3));
                                break;
                            } 
                            case "P":
                            {
                                aks.Basics.onAuthorizedCommandPrompt(sData.substr(3));
                                break;
                            } 
                            case "C":
                            {
                                aks.Basics.onAuthorizedCommandClear();
                                break;
                            } 
                            case "E":
                            {
                                aks.Basics.onAuthorizedCommand(false);
                                break;
                            } 
                        } // End of switch
                        break;
                    } 
                    case "T":
                    {
                        aks.Basics.onReferenceTime(sData.substr(2));
                        break;
                    } 
                    case "W":
                    {
                        aks.Basics.onWhoIs(!bError, sData.substr(3));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "A":
            {
                switch (sAction)
                {
                    case "l":
                    {
                        aks.Account.onLogin(!bError, sData.substr(3));
                        break;
                    } 
                    case "L":
                    {
                        aks.Account.onCharactersList(!bError, sData.substr(3));
                        break;
                    } 
                    case "A":
                    {
                        aks.Account.onCharacterAdd(!bError, sData.substr(3));
                        break;
                    } 
                    case "S":
                    {
                        aks.Account.onSelectCharacter(!bError, sData.substr(3));
                        break;
                    } 
                    case "T":
                    {
                        aks.Account.onTicketResponse(!bError, sData.substr(4));
                        break;
                    } 
                    case "s":
                    {
                        aks.Account.onStats(sData.substr(2));
                        break;
                    } 
                    case "N":
                    {
                        aks.Account.onNewLevel(sData.substr(2));
                        break;
                    } 
                    case "R":
                    {
                        aks.Account.onRestrictions(sData.substr(2));
                        break;
                    } 
                    case "H":
                    {
                        aks.Account.onHosts(sData.substr(2));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "G":
            {
                switch (sAction)
                {
                    case "C":
                    {
                        aks.Game.onCreate(!bError, sData.substr(4));
                        break;
                    } 
                    case "J":
                    {
                        aks.Game.onJoin(sData.substr(3));
                        break;
                    } 
                    case "P":
                    {
                        aks.Game.onPositionStart(sData.substr(2));
                        break;
                    } 
                    case "R":
                    {
                        aks.Game.onReady(sData.substr(2));
                        break;
                    } 
                    case "S":
                    {
                        aks.Game.onStartToPlay();
                        break;
                    } 
                    case "E":
                    {
                        aks.Game.onEnd(sData.substr(2));
                        break;
                    } 
                    case "M":
                    {
                        aks.Game.onMovement(sData.substr(3));
                        break;
                    } 
                    case "c":
                    {
                        aks.Game.onChallenge(sData.substr(2));
                        break;
                    } 
                    case "t":
                    {
                        aks.Game.onTeam(sData.substr(2));
                        break;
                    } 
                    case "V":
                    {
                        aks.Game.onLeave();
                        break;
                    } 
                    case "I":
                    {
                        switch (sData.charAt(2))
                        {
                            case "C":
                            {
                                aks.Game.onPlayersCoordinates(sData.substr(4));
                                break;
                            } 
                            case "E":
                            {
                                aks.Game.onEffect(sData.substr(3));
                                break;
                            } 
                        } // End of switch
                        break;
                    } 
                    case "D":
                    {
                        switch (sData.charAt(2))
                        {
                            case "M":
                            {
                                aks.Game.onMapData(sData.substr(4));
                                break;
                            } 
                            case "K":
                            {
                                aks.Game.onMapLoaded();
                                break;
                            } 
                            case "C":
                            {
                                aks.Game.onCellData(sData.substr(3));
                                break;
                            } 
                            case "Z":
                            {
                                aks.Game.onZoneData(sData.substring(3));
                                break;
                            } 
                            case "O":
                            {
                                aks.Game.onCellObject(sData.substring(3));
                                break;
                            } 
                            case "F":
                            {
                                aks.Game.onFrameObject2(sData.substring(4));
                                break;
                            } 
                        } // End of switch
                        break;
                    } 
                    case "A":
                    {
                        switch (sData.charAt(2))
                        {
                            case "S":
                            {
                                aks.GameActions.onActionsStart(sData.substr(3));
                                break;
                            } 
                            case "F":
                            {
                                aks.GameActions.onActionsFinish(sData.substr(3));
                                break;
                            } 
                            default:
                            {
                                aks.GameActions.onActions(sData.substr(2));
                            } 
                        } // End of switch
                        break;
                    } 
                    case "T":
                    {
                        switch (sData.charAt(2))
                        {
                            case "S":
                            {
                                aks.Game.onTurnStart(sData.substr(3));
                                break;
                            } 
                            case "F":
                            {
                                aks.Game.onTurnFinish(sData.substr(3));
                                break;
                            } 
                            case "L":
                            {
                                aks.Game.onTurnlist(sData.substr(4));
                                break;
                            } 
                            case "M":
                            {
                                aks.Game.onTurnMiddle(sData.substr(4));
                                break;
                            } 
                            case "R":
                            {
                                aks.Game.onTurnReady(sData.substr(3));
                                break;
                            } 
                        } // End of switch
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "c":
            {
                switch (sAction)
                {
                    case "M":
                    {
                        aks.Chat.onMessage(!bError, sData.substr(3));
                        break;
                    } 
                    case "s":
                    {
                        aks.Chat.onServerMessage(sData.substr(2));
                        break;
                    } 
                    case "S":
                    {
                        aks.Chat.onSmiley(sData.substr(2));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "D":
            {
                switch (sAction)
                {
                    case "C":
                    {
                        aks.Dialog.onCreate(!bError, sData.substr(3));
                        break;
                    } 
                    case "Q":
                    {
                        aks.Dialog.onQuestion(sData.substr(2));
                        break;
                    } 
                    case "V":
                    {
                        aks.Dialog.onLeave();
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "I":
            {
                switch (sAction)
                {
                    case "M":
                    {
                        aks.Infos.onInfoMaps(sData.substr(2));
                        break;
                    } 
                    case "C":
                    {
                        aks.Infos.onInfoCompass(sData.substr(2));
                        break;
                    } 
                    case "H":
                    {
                        aks.Infos.onInfoCoordinatespHighlight(sData.substr(2));
                        break;
                    } 
                    case "m":
                    {
                        aks.Infos.onMessage(sData.substr(2));
                        break;
                    } 
                    case "Q":
                    {
                        aks.Infos.onQuantity(sData.substr(2));
                        break;
                    } 
                    case "O":
                    {
                        aks.Infos.onObject(sData.substr(2));
                        break;
                    } 
                    case "L":
                    {
                        switch (sData.charAt(2))
                        {
                            case "S":
                            {
                                aks.Infos.onLifeRestoreTimerStart(sData.substr(3));
                                break;
                            } 
                            case "F":
                            {
                                aks.Infos.onLifeRestoreTimerFinish(sData.substr(3));
                                break;
                            } 
                        } // End of switch
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "S":
            {
                switch (sAction)
                {
                    case "L":
                    {
                        aks.Spells.onList(sData.substr(2));
                        break;
                    } 
                    case "U":
                    {
                        aks.Spells.onUpgradeSpell(!bError, sData.substr(3));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "O":
            {
                switch (sAction)
                {
                    case "a":
                    {
                        aks.Items.onAccessories(sData.substr(2));
                        break;
                    } 
                    case "D":
                    {
                        aks.Items.onDrop(!bError, sData.substr(3));
                        break;
                    } 
                    case "A":
                    {
                        aks.Items.onAdd(!bError, sData.substr(3));
                        break;
                    } 
                    case "C":
                    {
                        aks.Items.onChange(sData.substr(3));
                        break;
                    } 
                    case "R":
                    {
                        aks.Items.onRemove(sData.substr(2));
                        break;
                    } 
                    case "Q":
                    {
                        aks.Items.onQuantity(sData.substr(2));
                        break;
                    } 
                    case "M":
                    {
                        aks.Items.onMovement(sData.substr(2));
                        break;
                    } 
                    case "T":
                    {
                        aks.Items.onTool(sData.substr(2));
                        break;
                    } 
                    case "w":
                    {
                        aks.Items.onWeight(sData.substr(2));
                        break;
                    } 
                    case "S":
                    {
                        aks.Items.onItemSet(sData.substr(2));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "F":
            {
                switch (sAction)
                {
                    case "A":
                    {
                        aks.Friends.onAddFriend(!bError, sData.substr(3));
                        break;
                    } 
                    case "D":
                    {
                        aks.Friends.onRemoveFriend(!bError, sData.substr(3));
                        break;
                    } 
                    case "L":
                    {
                        aks.Friends.onFriendsList(sData.substr(3));
                        break;
                    } 
                    case "S":
                    {
                        aks.Friends.onSpouse(sData.substr(2));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "K":
            {
                switch (sAction)
                {
                    case "C":
                    {
                        aks.Key.onCreate(sData.substr(3));
                        break;
                    } 
                    case "K":
                    {
                        aks.Key.onKey(!bError);
                        break;
                    } 
                    case "V":
                    {
                        aks.Key.onLeave();
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "J":
            {
                switch (sAction)
                {
                    case "S":
                    {
                        aks.Job.onSkills(sData.substr(3));
                        break;
                    } 
                    case "X":
                    {
                        aks.Job.onXP(sData.substr(3));
                        break;
                    } 
                    case "N":
                    {
                        aks.Job.onLevel(sData.substr(2));
                        break;
                    } 
                    case "R":
                    {
                        aks.Job.onRemove(sData.substr(2));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "E":
            {
                switch (sAction)
                {
                    case "R":
                    {
                        aks.Exchange.onRequest(!bError, sData.substr(3));
                        break;
                    } 
                    case "K":
                    {
                        aks.Exchange.onReady(sData.substr(2));
                        break;
                    } 
                    case "V":
                    {
                        aks.Exchange.onLeave(!bError, sData.substr(3));
                        break;
                    } 
                    case "C":
                    {
                        aks.Exchange.onCreate(!bError, sData.substr(3));
                        break;
                    } 
                    case "c":
                    {
                        aks.Exchange.onCraft(!bError, sData.substr(3));
                        break;
                    } 
                    case "M":
                    {
                        aks.Exchange.onLocalMovement(!bError, sData.substr(3));
                        break;
                    } 
                    case "m":
                    {
                        aks.Exchange.onDistantMovement(!bError, sData.substr(3));
                        break;
                    } 
                    case "s":
                    {
                        aks.Exchange.onStorageMovement(!bError, sData.substr(3));
                        break;
                    } 
                    case "i":
                    {
                        aks.Exchange.onPlayerShopMovement(!bError, sData.substr(3));
                        break;
                    } 
                    case "L":
                    {
                        aks.Exchange.onList(sData.substr(2));
                        break;
                    } 
                    case "S":
                    {
                        aks.Exchange.onSell(!bError);
                        break;
                    } 
                    case "B":
                    {
                        aks.Exchange.onBuy(!bError);
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "h":
            {
                switch (sAction)
                {
                    case "L":
                    {
                        aks.Houses.onList(sData.substr(2));
                        break;
                    } 
                    case "P":
                    {
                        aks.Houses.onProperties(sData.substr(2));
                        break;
                    } 
                    case "X":
                    {
                        aks.Houses.onLockedProperty(sData.substr(2));
                        break;
                    } 
                    case "C":
                    {
                        aks.Houses.onCreate(sData.substr(3));
                        break;
                    } 
                    case "S":
                    {
                        aks.Houses.onSell(!bError, sData.substr(3));
                        break;
                    } 
                    case "B":
                    {
                        aks.Houses.onBuy(!bError, sData.substr(3));
                        break;
                    } 
                    case "V":
                    {
                        aks.Houses.onLeave();
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "s":
            {
                switch (sAction)
                {
                    case "L":
                    {
                        aks.Storages.onList(sData.substr(2));
                        break;
                    } 
                    case "X":
                    {
                        aks.Storages.onLockedProperty(sData.substr(2));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "e":
            {
                switch (sAction)
                {
                    case "U":
                    {
                        aks.Emotes.onUse(!bError, sData.substr(3));
                        break;
                    } 
                    case "L":
                    {
                        aks.Emotes.onList(sData.substr(2));
                        break;
                    } 
                    case "A":
                    {
                        aks.Emotes.onAdd(sData.substr(2));
                        break;
                    } 
                    case "R":
                    {
                        aks.Emotes.onRemove(sData.substr(2));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "d":
            {
                switch (sAction)
                {
                    case "C":
                    {
                        aks.Documents.onCreate(!bError, sData.substr(3));
                        break;
                    } 
                    case "V":
                    {
                        aks.Documents.onLeave();
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "g":
            {
                switch (sAction)
                {
                    case "n":
                    {
                        aks.Guild.onNew();
                        break;
                    } 
                    case "C":
                    {
                        aks.Guild.onCreate(!bError, sData.substr(3));
                        break;
                    } 
                    case "S":
                    {
                        aks.Guild.onStats(sData.substr(2));
                        break;
                    } 
                    case "I":
                    {
                        switch (sData.charAt(2))
                        {
                            case "G":
                            {
                                aks.Guild.onInfosGeneral(sData.substr(3));
                                break;
                            } 
                            case "M":
                            {
                                aks.Guild.onInfosMembers(sData.substr(3));
                                break;
                            } 
                            case "B":
                            {
                                aks.Guild.onInfosBoosts(sData.substr(3));
                                break;
                            } 
                            case "T":
                            {
                                switch (sData.charAt(3))
                                {
                                    case "M":
                                    {
                                        aks.Guild.onInfosTaxCollectorsMovement(sData.substr(4));
                                        break;
                                    } 
                                    case "P":
                                    {
                                        aks.Guild.onInfosTaxCollectorsPlayers(sData.substr(4));
                                        break;
                                    } 
                                    case "p":
                                    {
                                        aks.Guild.onInfosTaxCollectorsAttackers(sData.substr(4));
                                        break;
                                    } 
                                } // End of switch
                                break;
                            } 
                        } // End of switch
                        break;
                    } 
                    case "J":
                    {
                        switch (sData.charAt(2))
                        {
                            case "E":
                            {
                                aks.Guild.onJoinError(sData.substr(3));
                                break;
                            } 
                            case "R":
                            {
                                aks.Guild.onRequestLocal(sData.substr(3));
                                break;
                            } 
                            case "r":
                            {
                                aks.Guild.onRequestDistant(sData.substr(3));
                                break;
                            } 
                            case "K":
                            {
                                aks.Guild.onJoinOk(sData.substr(3));
                                break;
                            } 
                            case "C":
                            {
                                aks.Guild.onJoinDistantOk();
                                break;
                            } 
                        } // End of switch
                        break;
                    } 
                    case "V":
                    {
                        aks.Guild.onLeave();
                        break;
                    } 
                    case "K":
                    {
                        aks.Guild.onBann(!bError, sData.substr(3));
                        break;
                    } 
                    case "H":
                    {
                        aks.Guild.onHireTaxCollector(!bError, sData.substr(3));
                        break;
                    } 
                    case "A":
                    {
                        aks.Guild.onTaxCollectorAttacked(sData.substr(2));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "W":
            {
                switch (sAction)
                {
                    case "C":
                    {
                        aks.Waypoints.onCreate(sData.substr(2));
                        break;
                    } 
                    case "V":
                    {
                        aks.Waypoints.onLeave();
                        break;
                    } 
                    case "U":
                    {
                        aks.Waypoints.onUseError();
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "a":
            {
                switch (sAction)
                {
                    case "L":
                    {
                        aks.Areas.onList(sData.substr(3));
                        break;
                    } 
                    case "M":
                    {
                        aks.Areas.onAlignmentModification(sData.substr(2));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "Z":
            {
                switch (sAction)
                {
                    case "S":
                    {
                        aks.Specialization.onSet(sData.substr(2));
                        break;
                    } 
                    case "C":
                    {
                        aks.Specialization.onChange(sData.substr(2));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "f":
            {
                switch (sAction)
                {
                    case "C":
                    {
                        aks.Fights.onCount(sData.substr(2));
                        break;
                    } 
                    case "L":
                    {
                        aks.Fights.onList(sData.substr(2));
                        break;
                    } 
                    case "D":
                    {
                        aks.Fights.onDetails(sData.substr(2));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case "T":
            {
                switch (sAction)
                {
                    case "C":
                    {
                        aks.Tutorial.onCreate(sData.substr(2));
                        break;
                    } 
                } // End of switch
                break;
            } 
        } // End of switch
    } // End of the function
} // End of Class
#endinitclip
