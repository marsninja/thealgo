import from datetime { datetime }


node Life {}
node Year {
    has year: int;
}


node Month {}
node Day {}


walker get_tasks {
    has target_day: datetime = datetime.now();

    can move with Life entry {
        visit [->:Year : year == self.target_day.year :->] else {
            x = here ++> Year(year=self.target_day.year);
            print(x);
        }
    }
}


test get_tasks_works { get_tasks() spawn Life(); }
