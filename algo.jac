import from datetime { datetime }

node Life {}
node Year {
    has year: int;
}

node Month {}
node Day {}
walker get_tasks {
    has target_day: datetime = datetime.now();

    can with `root entry {
        visit [->:Life :->] else {
            visit here ++> Life();
            report "Created Life node" ;
        }
    }

    can with Life entry {
        visit [->:Year : year == self.target_day.year :->] else {
            visit here ++> Year(year=self.target_day.year);
            report "Created Year node for " + self.target_day.year ;
        }
    }

    can with Year entry {
        visit [->:Month : month == self.target_day.month :->] else {
            visit here ++> Month();
            report "Created Month node for " + self.target_day.month ;
        }
    }

    can with Month entry {
        visit [->:Day : day == self.target_day.day :->] else {
            visit here ++> Day();
            report "Created Day node for " + self.target_day.day ;
        }
    }

    can with Day entry {
        report "Found Day node for " + self.target_day.day ;
    }
}

# test get_tasks_works { get_tasks() spawn Life(); }
with entry {
    get_tasks() spawn root;
}
