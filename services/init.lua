
load_all("services", {
    "DoNotDisturbService",
    "NotificationService",
    "VolumeService",
})


-- DO NOT EDIT! To disable service remove it from 'load_all' function above
--- @type Initializable[]
local services = {
    DoNotDisturbService,
    NotificationService,
    VolumeService,
    ClientMover,
    PostureCheckNotificator
}

for i, service in pairs(services) do
    if service then
        service.init()
    end
end