Config = {}

Config.Peds = {
    ['trucker'] = {
        job = 'trucker',
        jobName = 'Trucker',
        coords = vector4(1197.08, -3253.49, 7.1, 90.73),
        ped = 'mp_m_waremech_01',
        scenario = 'WORLD_HUMAN_COP_IDLES',
        targetIcon = 'fas fa-truck',
        targetLabel = 'Interact for Jobs',
        showBlip = true,
        blipName = 'Trucker Job',
        blipSprite = 267,
        blipColor = 2,
        blipScale = 0.5
    },
    -- You can reproduce it as many times as you want in accordance with the example below.
    --[[ ['taxi'] = {
        job = 'taxi',
        jobName = 'Taxi Driver',
        coords = vector4(1188.4, -3249.39, 6.03, 259.1),
        ped = 'a_f_m_bevhills_01',
        scenario = 'WORLD_HUMAN_COP_IDLES',
        targetIcon = 'fas fa-truck',
        targetLabel = 'Interact for Jobs',
        showBlip = true,
        blipName = 'Taxi Job',
        blipSprite = 267,
        blipColor = 2,
        blipScale = 0.5
    }, ]]
}

Config.Text = {
    ['notify'] = 'If you already have a job, you will lose your job when you choose an additional job..',
    ['header'] = 'Job Menu',

    ['takeJob_h'] = 'Take Job',
    ['takeJob_t'] = 'With this option, you can have the profession ',

    ['leaveJob_h'] = 'Leave Job',
    ['leaveJob_t'] = 'You\'re bored with the job, you\'ll turn civilian and chase new business.'
}
