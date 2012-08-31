// Action script...

// [Initial MovieClip Action of sprite 1044]
#initclip 11
class dofus.graphics.gapi.controls.GuildMembersViewer extends ank.gapi.core.UIAdvancedComponent
{
    var __get__members, addToQueue, _dgMembers, api, _lblDescription, _lblCount, __set__members;
    function GuildMembersViewer()
    {
        super();
    } // End of the function
    function set members(eaMembers)
    {
        this.updateData(eaMembers);
        //return (this.members());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.GuildMembersViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function addListeners()
    {
        _dgMembers.addEventListener("itemSelected", this);
    } // End of the function
    function initTexts()
    {
        _dgMembers.__set__columnsNames(["", "", api.lang.getText("NAME_BIG"), api.lang.getText("GUILD_RANK"), api.lang.getText("LEVEL_SMALL"), api.lang.getText("PERCENT_XP"), api.lang.getText("WIN_XP"), ""]);
        _lblDescription.__set__text(api.lang.getText("GUILD_MEMBERS_LIST"));
    } // End of the function
    function updateData(eaMembers)
    {
        _lblCount.__set__text(String(eaMembers.length) + " " + ank.utils.PatternDecoder.combine(api.lang.getText("MEMBERS"), "m", eaMembers.length < 2));
        _dgMembers.__set__dataProvider(eaMembers);
    } // End of the function
    function itemSelected(oEvent)
    {
        var _loc2 = oEvent.target.item;
        if (_loc2.name != api.datacenter.Player.Name)
        {
            if (_loc2.state == 0)
            {
                api.kernel.showMessage(undefined, api.lang.getText("USER_NOT_CONNECTED", [_loc2.name]), "ERROR_CHAT");
            }
            else
            {
                api.kernel.GameManager.askPrivateMessage(oEvent.target.item.name);
            } // end if
        } // end else if
    } // End of the function
    static var CLASS_NAME = "GuildMembersViewer";
} // End of Class
#endinitclip
