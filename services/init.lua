
load_all("services", {
    "NotificationService",
    "VolumeService",
    "ClientMoverService",
    "PostureCheckNotificator",
})


-- DO NOT EDIT! To disable service remove it from 'load_all' function above
--- @type Initializable[]
local services = {
    ClientMoverService,
}

for i, service in pairs(services) do
    if service then
        service.init()
    end
end
