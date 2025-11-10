import from datetime { datetime }

node Life {}
node Year {
    has year: int;
}

node Month {
    has month: int;
}

node Day {
    has day: int;
}

walker get_tasks {
    has target_day: datetime = datetime.now();

    can with `root entry {
        visit [-->(`?Life)] else {
            visit here ++> Life();
            report "Created Life node" ;
        }
    }

    can with Life entry {
        visit [-->(`?Year:year==self.target_day.year)] else {
            visit here ++> Year(year=self.target_day.year);
            report f"Created Year node for {self.target_day.year}" ;
        }
    }

    can with Year entry {
        visit [-->(`?Month:month==self.target_day.month)] else {
            visit here ++> Month(month=self.target_day.month);
            report f"Created Month node for {self.target_day.month}" ;
        }
    }

    can with Month entry {
        visit [-->(`?Day:day==self.target_day.day)] else {
            visit here ++> Day(day=self.target_day.day);
            report f"Created Day node for {self.target_day.day}" ;
        }
    }

    can with Day entry {
        report f"Found Day node for {self.target_day.day}" ;
    }
}

# test get_tasks_works { get_tasks() spawn Life(); }
with entry {
    get_tasks() spawn root;
}
