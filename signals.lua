--- @class Signals
local signals = {
    volume_increase = "volume::increase", --- shouldDisplayPopup: boolean \
    volume_decrease = "volume::decrease", --- shouldDisplayPopup: boolean \
    volume_toggle = "volume::toggle", --- shouldDisplayPopup: boolean \
    volume_update = "volume::update", ---  \ Needed to update volume service
    volume_update_widgets = "volume::update_widget", --- newVolume: number, isMute boolean, shoulDisplayPopup boolean \
    volume_set = "volume::set", --- newValue: number, shouldDisplayPopup: boolean
}

return signals
